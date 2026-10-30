# PowerShell 7; API must run locally with the https Development profile.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'get-admin-test-headers.ps1')
$base = 'https://localhost:7044/api/admin'
function Request($method, $path, $body, $expected) {
    $options = @{ Uri = "$base/$path"; Method = $method; Headers = $adminHeaders; SkipCertificateCheck = $true; SkipHttpErrorCheck = $true }
    if ($null -ne $body) { $options.Body = $body | ConvertTo-Json; $options.ContentType = 'application/json; charset=utf-8' }
    $r = Invoke-WebRequest @options
    if ([int]$r.StatusCode -ne $expected) { throw "$method $path expected $expected, got $($r.StatusCode): $($r.Content)" }
    if ($r.Content) { return $r.Content | ConvertFrom-Json }
}
foreach ($resource in @('categories', 'brands')) {
    $createdIds = [System.Collections.Generic.List[int]]::new()
    try {
        $marker = 'synthetic-test-' + [guid]::NewGuid().ToString('N')
        $first = Request POST $resource @{ name = "  $marker  " } 201
        $createdIds.Add([int]$first.id)
        if ($first.name -ne $marker) { throw 'Name was not trimmed' }
        $null = Request POST $resource @{ name = $marker } 409
        $second = Request POST $resource @{ name = "$marker-2" } 201
        $createdIds.Add([int]$second.id)
        $null = Request PUT "$resource/$($second.id)" @{ name = $marker } 409
        $null = Request PUT "$resource/$($first.id)" @{ name = "$marker-renamed" } 204
        $read = Request GET "$resource/$($first.id)" $null 200
        if ($read.name -ne "$marker-renamed") { throw 'Rename failed' }
        foreach ($badName in @('', '   ', ('x' * 101))) {
            $null = Request POST $resource @{ name = $badName } 400
        }
        $null = Request POST $resource @{ name = $null } 400
        $null = Request GET "$resource/2147483647" $null 404
        $null = Request PUT "$resource/2147483647" @{ name = $marker } 404
        $null = Request DELETE "$resource/2147483647" $null 404
        # Create our own referenced product instead of attempting to delete user data.
        $lookups = Request GET 'products/lookups' $null 200
        $productId = 0
        try {
            $categoryId = if ($resource -eq 'categories') { $first.id } else { $lookups.categories[0].id }
            $brandId = if ($resource -eq 'brands') { $first.id } else { $lookups.brands[0].id }
            $product = Request POST 'products' @{name=$marker;categoryId=$categoryId;brandId=$brandId;isActive=$false} 201
            $productId = [int]$product.id
            $null = Request DELETE "$resource/$($first.id)" $null 409
        }
        finally {
            if ($productId -gt 0) {
                $query = "IF DB_NAME() <> N'GenZFashionDb' OR CONVERT(nvarchar(128),SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS' THROW 50000,'Unexpected target',1; DELETE FROM dbo.Products WHERE Id=$productId AND Name=N'$marker';"
                & sqlcmd -S 'KHANHS\SQLEXPRESS' -E -N -C -I -d GenZFashionDb -b -Q $query
                if ($LASTEXITCODE -ne 0) { throw 'Lookup test product cleanup failed' }
            }
        }
        "PASS: $resource create, trim, rename, duplicate, validation, referenced-delete protection, 404."
    }
    finally {
        foreach ($id in $createdIds) {
            $null = Request DELETE "$resource/$id" $null 204
            $null = Request GET "$resource/$id" $null 404
        }
    }
}
'PASS: temporary lookup records deleted through API.'

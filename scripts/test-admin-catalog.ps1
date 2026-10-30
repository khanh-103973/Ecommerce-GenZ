# Run with PowerShell 7 while the Development API is listening on localhost:7044.
# Creates one uniquely named synthetic product, then removes only that test record.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'get-admin-test-headers.ps1')
$base = 'https://localhost:7044'
$marker = 'synthetic-test-' + [guid]::NewGuid().ToString('N')
$productId = 0
function Request($method, $path, $body, $expected) {
    $options = @{ Uri = "$base$path"; Method = $method; Headers = $adminHeaders; SkipCertificateCheck = $true; SkipHttpErrorCheck = $true }
    if ($null -ne $body) { $options.Body = $body | ConvertTo-Json -Depth 8; $options.ContentType = 'application/json; charset=utf-8' }
    $response = Invoke-WebRequest @options
    if ([int]$response.StatusCode -ne $expected) { throw "$method $path expected $expected, got $($response.StatusCode): $($response.Content)" }
    if ($response.Content) { return $response.Content | ConvertFrom-Json }
}
try {
    $lookup = Request GET '/api/admin/products/lookups' $null 200
    $product = @{ name = $marker; description = 'synthetic integration test'; categoryId = $lookup.categories[0].id; brandId = $lookup.brands[0].id; isActive = $true }
    $created = Request POST '/api/admin/products' $product 201
    $productId = [int]$created.id
    $path = "/api/admin/products/$productId"
    $null = Request GET "/api/products/$productId" $null 200
    $imagePath = "$path/images"
    $first = Request POST $imagePath @{url='https://example.test/synthetic-a.jpg';altText='Synthetic A';sortOrder=1} 201
    $second = Request POST $imagePath @{url='https://example.test/synthetic-b.jpg';altText='Synthetic B';sortOrder=0} 201
    $public = Request GET "/api/products/$productId" $null 200
    if ($public.images.Count -ne 2 -or $public.images[0].id -ne $second.id) { throw 'Image ordering failed' }
    $listing = Request GET "/api/products?search=$marker" $null 200
    if ($listing.items[0].imageUrl -ne $second.url) { throw 'Cover image failed' }
    foreach ($badUrl in @('http://example.test/a.jpg','javascript:alert(1)','/relative.jpg','https://user:password@example.test/a.jpg')) {
        $null = Request POST $imagePath @{url=$badUrl;altText='';sortOrder=0} 400
    }
    $null = Request POST $imagePath @{url='https://example.test/a.jpg';altText='';sortOrder=-1} 400
    $null = Request PUT "$imagePath/$($first.id)" @{url='https://example.test/synthetic-updated.jpg';altText='Updated';sortOrder=0} 204
    $ordered = @(Request GET $imagePath $null 200)
    if ($ordered[0].id -ne $first.id -or $ordered[0].altText -ne 'Updated') { throw 'Image update or tie-break failed' }
    $null = Request PUT "/api/admin/products/2147483647/images/$($first.id)" @{url='https://example.test/a.jpg';altText='';sortOrder=0} 404
    $null = Request DELETE "/api/admin/products/2147483647/images/$($first.id)" $null 404
    $null = Request GET '/api/admin/products/2147483647/images' $null 404
    $null = Request DELETE "$imagePath/$($first.id)" $null 204
    $public = Request GET "/api/products/$productId" $null 200
    if ($public.images[0].id -ne $second.id) { throw 'Cover fallback failed' }
    $null = Request DELETE "$imagePath/$($second.id)" $null 204
    $listing = Request GET "/api/products?search=$marker" $null 200
    if ($null -ne $listing.items[0].imageUrl) { throw 'Empty cover should be null' }
    'PASS: HTTPS validation, image CRUD, ordering, cover fallback, empty cover and product scoping.'
    $variant = @{ sku = $marker; size = 'M'; color = 'Black'; price = 250000; stockQuantity = 10; isActive = $true }
    $added = Request POST "$path/variants" $variant 201
    $null = Request POST "$path/variants" $variant 409
    $variant.sku = "$marker-other"
    $null = Request POST "$path/variants" $variant 409
    $variant.sku = $marker
    $variant.stockQuantity = -1
    $null = Request POST "$path/variants" $variant 400
    $variant.stockQuantity = 8
    $variant.price = 1.5
    $null = Request POST "$path/variants" $variant 400
    $variant.price = 250000
    $variant.rowVersion = $added.rowVersion
    $updated = Request PUT "$path/variants/$($added.id)" $variant 200
    $variant.stockQuantity = 3
    $null = Request PUT "$path/variants/$($added.id)" $variant 409
    $detail = Request GET $path $null 200
    if ($detail.variants[0].stockQuantity -ne 8) { throw 'Stale update changed stock' }
    $variant.rowVersion = $updated.rowVersion
    $variant.isActive = $false
    $null = Request PUT "$path/variants/$($added.id)" $variant 200
    $public = Request GET "/api/products/$productId" $null 200
    if ($public.variants.Count -ne 0) { throw 'Hidden variant exposed' }
    $product.isActive = $false
    $null = Request PUT $path $product 204
    $null = Request GET "/api/products/$productId" $null 404
    $null = Request GET $path $null 200
    $product.categoryId = 2147483647
    $null = Request PUT $path $product 400
    $product.name = '   '
    $null = Request POST '/api/admin/products' $product 400
    $null = Request GET '/api/admin/products?page=0' $null 400
    $null = Request GET '/api/admin/products/2147483647' $null 404
    'PASS: create/update, duplicates, validation, concurrency, hidden product/variant, missing resource.'
}
finally {
    if ($productId -gt 0) {
        $query = @"
SET XACT_ABORT ON;
IF CONVERT(nvarchar(128), SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS' OR DB_NAME() <> N'GenZFashionDb' THROW 50000, 'Unexpected target.', 1;
BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM dbo.Products WHERE Id=$productId AND Name=N'$marker')
BEGIN
DELETE FROM dbo.ProductVariants WHERE ProductId=$productId;
DELETE FROM dbo.Products WHERE Id=$productId AND Name=N'$marker';
END;
COMMIT;
"@
        & sqlcmd -S 'KHANHS\SQLEXPRESS' -E -N -C -d GenZFashionDb -b -Q $query
        if ($LASTEXITCODE -ne 0) { throw "Test cleanup failed for product $productId" }
    }
}

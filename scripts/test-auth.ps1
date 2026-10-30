$ErrorActionPreference = 'Stop'
$base = 'https://localhost:7044'
$email = 'synthetic-' + [guid]::NewGuid().ToString('N') + '@example.test'
$password = [Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(24)) + 'Aa1!'
function Request($method, $path, $body, $token, $expected) {
    $options = @{ Uri = "$base$path"; Method = $method; SkipCertificateCheck = $true; SkipHttpErrorCheck = $true }
    if ($token) { $options.Headers = @{ Authorization = "Bearer $token" } }
    if ($null -ne $body) { $options.Body = $body | ConvertTo-Json; $options.ContentType = 'application/json' }
    $r = Invoke-WebRequest @options
    if ([int]$r.StatusCode -ne $expected) { throw "$method $path expected $expected, got $($r.StatusCode)" }
    if ($r.Content) { return $r.Content | ConvertFrom-Json }
}
function Encode64([byte[]]$bytes) { [Convert]::ToBase64String($bytes).TrimEnd('=').Replace('+','-').Replace('/','_') }
try {
    foreach ($resource in @('products','categories','brands')) {
        $null = Request GET "/api/admin/$resource" $null $null 401
    }
    $null = Request GET '/api/products' $null $null 200
    $body = @{ email = $email; password = 'weak'; fullName = 'Synthetic auth test'; role = 'Admin' }
    $null = Request POST '/api/auth/register' $body $null 400
    $body.password = $password
    $user = Request POST '/api/auth/register' $body $null 201
    if ($user.role -ne 'Customer') { throw 'Role escalation' }
    $null = Request POST '/api/auth/register' $body $null 400
    $login = Request POST '/api/auth/login' @{ email=$email; password=$password } $null 200
    $me = Request GET '/api/auth/me' $null $login.accessToken 200
    if ($me.roles.Count -ne 1 -or $me.roles[0] -ne 'Customer') { throw 'Wrong customer role' }
    foreach ($resource in @('products','categories','brands')) {
        $null = Request GET "/api/admin/$resource" $null $login.accessToken 403
        $null = Request POST "/api/admin/$resource" @{ name='unauthorized' } $login.accessToken 403
    }
    $null = Request GET '/api/auth/me' $null 'invalid.token.here' 401
    . (Join-Path $PSScriptRoot 'get-admin-test-headers.ps1')
    $adminToken = $adminHeaders.Authorization.Substring(7)
    foreach ($resource in @('products','categories','brands')) {
        $null = Request GET "/api/admin/$resource" $null $adminToken 200
    }
    # Sign an expired JWT with the local key to verify lifetime validation itself.
    $secretPath = Join-Path $env:APPDATA 'Microsoft\UserSecrets\genzfashion-local-identity-7cc492f6\secrets.json'
    $secrets = Get-Content $secretPath -Raw | ConvertFrom-Json -AsHashtable
    $header = Encode64 ([Text.Encoding]::UTF8.GetBytes('{"alg":"HS256","typ":"JWT"}'))
    $payload = @{ sub=$user.id; iss='GenZFashion.Api'; aud='GenZFashion.Client'; role='Admin'; exp=[DateTimeOffset]::UtcNow.AddMinutes(-1).ToUnixTimeSeconds() } | ConvertTo-Json -Compress
    $unsigned = $header + '.' + (Encode64 ([Text.Encoding]::UTF8.GetBytes($payload)))
    $hmac = [Security.Cryptography.HMACSHA256]::new([Text.Encoding]::UTF8.GetBytes($secrets['Jwt:SigningKey']))
    $expired = $unsigned + '.' + (Encode64 ($hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes($unsigned))))
    $hmac.Dispose()
    $null = Request GET '/api/admin/products' $null $expired 401
    for ($i=0; $i -lt 5; $i++) {
        $null = Request POST '/api/auth/login' @{ email=$email; password='Incorrect123!' } $null 401
    }
    $null = Request POST '/api/auth/login' @{ email=$email; password=$password } $null 401
    'PASS: registration, duplicate/weak password, customer-only registration, JWT/me, 401/403/200, expired token, account lockout.'
}
finally {
    # Only remove the randomly named synthetic account created by this run.
    $query = "IF DB_NAME() <> N'GenZFashionDb' OR CONVERT(nvarchar(128),SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS' THROW 50000, 'Unexpected target', 1; DELETE FROM dbo.AspNetUsers WHERE Email=N'$email' AND FullName=N'Synthetic auth test';"
    & sqlcmd -S 'KHANHS\SQLEXPRESS' -E -N -C -I -d GenZFashionDb -b -Q $query
    if ($LASTEXITCODE -ne 0) { throw 'Auth test cleanup failed' }
}

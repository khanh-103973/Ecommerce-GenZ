# API must already be running with the https Development profile.
# A temporary synthetic admin avoids changing the real admin's password.
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)
$email = 'synthetic-admin-' + [guid]::NewGuid().ToString('N') + '@example.test'
$password = [Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(24)) + 'Aa1!'
$previous = @{}
foreach ($key in @('BootstrapAdmin__Email','BootstrapAdmin__Password','GENZFASHION_TEST_ADMIN_EMAIL','GENZFASHION_TEST_ADMIN_PASSWORD')) {
    $previous[$key] = [Environment]::GetEnvironmentVariable($key, 'Process')
}
try {
    $env:BootstrapAdmin__Email=$email
    $env:BootstrapAdmin__Password=$password
    $env:GENZFASHION_TEST_ADMIN_EMAIL=$email
    $env:GENZFASHION_TEST_ADMIN_PASSWORD=$password
    dotnet run --project GenZFashion.Api --no-build --launch-profile https -- --bootstrap-admin
    if ($LASTEXITCODE -ne 0) { throw 'Cannot create synthetic admin' }
    foreach ($script in @('test-auth.ps1','test-commerce.ps1','test-admin-catalog.ps1','test-admin-lookups.ps1')) {
        & pwsh -NoProfile -File (Join-Path $PSScriptRoot $script)
        if ($LASTEXITCODE -ne 0) { throw "Failed: $script" }
    }
}
finally {
    $query="IF DB_NAME() <> N'GenZFashionDb' OR CONVERT(nvarchar(128),SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS' THROW 50000,'Unexpected target',1; DELETE FROM dbo.AspNetUsers WHERE Email=N'$email' AND FullName=N'Local demo administrator';"
    & sqlcmd -S 'KHANHS\SQLEXPRESS' -E -N -C -I -d GenZFashionDb -b -Q $query
    foreach ($key in $previous.Keys) { [Environment]::SetEnvironmentVariable($key,$previous[$key],'Process') }
    $password=$null
    if ($LASTEXITCODE -ne 0) { throw 'Synthetic admin cleanup failed' }
}

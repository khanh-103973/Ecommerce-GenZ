# Run on your own Windows session. Explicitly resets ONLY the local demo admin password.
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)
$securePassword = Read-Host 'Nhap mat khau admin moi (>=10 ky tu, chu hoa/thuong, so, ky tu dac biet)' -AsSecureString
$pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
try { $password = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer) }
finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer) }
if ($password.Length -lt 10 -or $password -cnotmatch '[A-Z]' -or $password -cnotmatch '[a-z]' -or $password -notmatch '[0-9]' -or $password -notmatch '[^a-zA-Z0-9]') {
    throw 'Mat khau chua dat yeu cau. Chua thay doi cau hinh.'
}
$secretDirectory = Join-Path $env:APPDATA 'Microsoft\UserSecrets\genzfashion-local-identity-7cc492f6'
$secretFile = Join-Path $secretDirectory 'secrets.json'
$values = @{}
if (Test-Path $secretFile) {
    $existing = Get-Content -LiteralPath $secretFile -Raw | ConvertFrom-Json
    foreach ($property in $existing.PSObject.Properties) { $values[$property.Name] = $property.Value }
}
if ([string]::IsNullOrWhiteSpace($values['Jwt:SigningKey'])) {
    $bytes = New-Object byte[] 64
    $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
    try { $rng.GetBytes($bytes) } finally { $rng.Dispose() }
    $values['Jwt:SigningKey'] = [Convert]::ToBase64String($bytes)
}
$values['BootstrapAdmin:Email'] = 'admin@genzfashion.test'
$values['BootstrapAdmin:Password'] = $password
New-Item -ItemType Directory -Path $secretDirectory -Force | Out-Null
$json = $values | ConvertTo-Json
[IO.File]::WriteAllText($secretFile, $json, (New-Object Text.UTF8Encoding($false)))
$password = $null
$values = $null
$json = $null
Write-Host 'Da ghi User Secrets trong phien Windows hien tai. Khong in bi mat.'
dotnet run --project GenZFashion.Api --launch-profile https -- --bootstrap-admin --reset-local-admin-password
if ($LASTEXITCODE -ne 0) { throw 'Chua doi duoc mat khau admin. Gui thong bao loi, khong gui secrets.' }
Write-Host 'Hoan tat. Email: admin@genzfashion.test. Mat khau la mat khau ban vua nhap.'

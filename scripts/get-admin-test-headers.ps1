# Local test helper. Function scope prevents overwriting the caller's test user.
function Get-LocalAdminTestHeaders {
    if ($env:GENZFASHION_TEST_ADMIN_EMAIL -and $env:GENZFASHION_TEST_ADMIN_PASSWORD) {
        $email = $env:GENZFASHION_TEST_ADMIN_EMAIL
        $password = $env:GENZFASHION_TEST_ADMIN_PASSWORD
    }
    else {
        $localSecretsPath = Join-Path $env:APPDATA 'Microsoft\UserSecrets\genzfashion-local-identity-7cc492f6\secrets.json'
        $localSecrets = Get-Content -LiteralPath $localSecretsPath -Raw | ConvertFrom-Json -AsHashtable
        $email = $localSecrets['BootstrapAdmin:Email']
        $password = $localSecrets['BootstrapAdmin:Password']
    }
    $loginBody = @{ email = $email; password = $password } | ConvertTo-Json
    $loginResult = Invoke-RestMethod 'https://localhost:7044/api/auth/login' -Method Post -ContentType 'application/json' -Body $loginBody -SkipCertificateCheck
    return @{ Authorization = "Bearer $($loginResult.accessToken)" }
}
$adminHeaders = Get-LocalAdminTestHeaders

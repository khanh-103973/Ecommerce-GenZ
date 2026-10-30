# PowerShell 7. Run after building the API. No real database or real secrets are used.
$ErrorActionPreference = 'Stop'
$dll = Join-Path (Split-Path $PSScriptRoot -Parent) 'GenZFashion.Api/bin/Debug/net10.0/GenZFashion.Api.dll'
if (!(Test-Path -LiteralPath $dll)) { throw 'Build the API before this test.' }
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
$listener.Start()
$port = $listener.LocalEndpoint.Port
$listener.Stop()
$base = "http://127.0.0.1:$port"
$start = [Diagnostics.ProcessStartInfo]::new('dotnet')
$start.UseShellExecute = $false
$start.CreateNoWindow = $true
$start.RedirectStandardOutput = $true
$start.RedirectStandardError = $true
$start.ArgumentList.Add($dll)
$start.ArgumentList.Add('--urls')
$start.ArgumentList.Add($base)
$start.Environment['ASPNETCORE_ENVIRONMENT'] = 'Production'
$start.Environment['DOTNET_ENVIRONMENT'] = 'Production'
$start.Environment['Jwt__SigningKey'] = [Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(64))
# Port 1 is deliberately unreachable. No schema or data is created or modified.
$start.Environment['ConnectionStrings__GenZFashionDb'] = 'Server=tcp:127.0.0.1,1;Database=GenZFashionDb;Integrated Security=True;Encrypt=True;Connect Timeout=1;ConnectRetryCount=0'
$start.Environment['Logging__LogLevel__Default'] = 'Warning'
$process = [Diagnostics.Process]::new()
$process.StartInfo = $start
$started = $false
function ReadJson($response) {
    $text = if ($response.Content -is [byte[]]) { [Text.Encoding]::UTF8.GetString($response.Content) } else { [string]$response.Content }
    return $text | ConvertFrom-Json -AsHashtable
}
try {
    $null = $process.Start()
    $started = $true
    $stdout = $process.StandardOutput.ReadToEndAsync()
    $stderr = $process.StandardError.ReadToEndAsync()
    $ready=$false
    for ($attempt=0; $attempt -lt 40; $attempt++) {
        if ($process.HasExited) { throw 'Isolated API exited before becoming ready.' }
        try {
            $response = Invoke-WebRequest "$base/api/not-a-real-route" -SkipHttpErrorCheck -TimeoutSec 2
            if ($response.StatusCode -eq 404) { $ready=$true; break }
        }
        catch { Start-Sleep -Milliseconds 250 }
    }
    if (!$ready) { throw 'Isolated API did not become ready.' }
    $live=Invoke-WebRequest "$base/api/health/live" -SkipHttpErrorCheck -TimeoutSec 10
    $database=Invoke-WebRequest "$base/api/health/ready" -SkipHttpErrorCheck -TimeoutSec 10
    if ($live.StatusCode -ne 200 -or [string]$live.Content -ne 'Healthy') { throw 'API liveness failed when database is unavailable.' }
    if ($database.StatusCode -ne 503 -or [string]$database.Content -ne 'Unhealthy') { throw 'Database readiness must return 503 without exposing details.' }
    foreach ($accept in @('application/json','text/html')) {
        $response=Invoke-WebRequest "$base/api/products" -Headers @{Accept=$accept} -SkipHttpErrorCheck -TimeoutSec 15
        $problem=ReadJson $response
        if ($response.StatusCode -ne 500 -or $problem.status -ne 500 -or !$problem.traceId -or !$problem.detail) {
            throw "Expected safe 500 for Accept=$accept; HTTP=$($response.StatusCode), payloadStatus=$($problem.status), hasTraceId=$([bool]$problem.traceId), hasDetail=$([bool]$problem.detail)."
        }
        if ([string]$response.Headers['Content-Type'] -notlike 'application/problem+json*') { throw '500 must be JSON even for HTML Accept.' }
        $text=$problem | ConvertTo-Json -Depth 8
        if ($text -match 'SqlException|Microsoft\.Data|stackTrace|exception|127\.0\.0\.1,1') { throw 'Internal failure details leaked to the response.' }
    }
    foreach ($path in @('/swagger/index.html','/openapi/v1.json','/health/database')) {
        $response=Invoke-WebRequest "$base$path" -SkipHttpErrorCheck
        if ($response.StatusCode -ne 404) { throw "Development endpoint exposed in Production: $path" }
    }
    for ($i=1; $i -le 31; $i++) {
        $authPath=if($i % 2 -eq 0){'register'}else{'login'}
        $response=Invoke-WebRequest "$base/api/auth/$authPath" -Method Post -ContentType 'application/json' -Body '{}' -SkipHttpErrorCheck
        $expected=if($i -le 30){400}else{429}
        if ($response.StatusCode -ne $expected) { throw "Unexpected isolated rate limit response at request $i" }
    }
    $problem=ReadJson $response
    if ($problem.status -ne 429 -or !$problem.detail -or !$problem.traceId) { throw 'Missing JSON rate limit response.' }
    'PASS: isolated Production live=200, ready=503, safe JSON 500, hidden Development endpoints and shared auth JSON 429; no real database used.'
}
finally {
    if ($started -and !$process.HasExited) { $process.Kill($true); $process.WaitForExit() }
    $process.Dispose()
    $start.Environment.Remove('Jwt__SigningKey') | Out-Null
}

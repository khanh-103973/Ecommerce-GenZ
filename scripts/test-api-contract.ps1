# Read-only checks: no credentials, registration or database writes.
$ErrorActionPreference = 'Stop'
$base = 'https://localhost:7044'
function ReadJson($response) {
    $text = if ($response.Content -is [byte[]]) { [Text.Encoding]::UTF8.GetString($response.Content) } else { [string]$response.Content }
    return $text | ConvertFrom-Json -AsHashtable
}
$document = ReadJson (Invoke-WebRequest "$base/openapi/v1.json" -SkipCertificateCheck)
# Explicit expected success codes, independent of generated controller metadata.
$expected = @{
    '/api/catalog' = @{get=200}
    '/api/products' = @{get=200}
    '/api/products/{id}' = @{get=200}
    '/api/auth/register' = @{post=201}
    '/api/auth/login' = @{post=200}
    '/api/auth/me' = @{get=200}
    '/api/cart' = @{get=200}
    '/api/cart/items/{variantId}' = @{put=204;delete=204}
    '/api/orders' = @{get=200;post=201}
    '/api/orders/{id}' = @{get=200}
    '/api/orders/{id}/cancel' = @{post=204}
    '/api/admin/dashboard' = @{get=200}
    '/api/admin/products' = @{get=200;post=201}
    '/api/admin/products/lookups' = @{get=200}
    '/api/admin/products/{id}' = @{get=200;put=204}
    '/api/admin/products/{id}/variants' = @{post=201}
    '/api/admin/products/{id}/variants/{variantId}' = @{put=200}
    '/api/admin/products/{productId}/images' = @{get=200;post=201}
    '/api/admin/products/{productId}/images/{imageId}' = @{put=204;delete=204}
    '/api/admin/categories' = @{get=200;post=201}
    '/api/admin/categories/{id}' = @{get=200;put=204;delete=204}
    '/api/admin/brands' = @{get=200;post=201}
    '/api/admin/brands/{id}' = @{get=200;put=204;delete=204}
    '/api/admin/orders' = @{get=200}
    '/api/admin/orders/{id}' = @{get=200}
    '/api/admin/orders/{id}/status' = @{put=204}
    '/api/admin/customers' = @{get=200}
    '/api/admin/customers/{id}' = @{get=200}
    '/api/admin/customers/{id}/orders' = @{get=200}
}
$count=0
foreach ($path in $expected.Keys) {
    foreach ($method in $expected[$path].Keys) {
        $operation = $document.paths[$path][$method]
        if (!$operation) { throw "Missing operation: $method $path" }
        $code = [string]$expected[$path][$method]
        $successes = @($operation.responses.Keys | Where-Object { $_ -match '^2\d\d$' })
        if ($successes.Count -ne 1 -or $successes[0] -ne $code) { throw "Wrong success metadata: $method $path" }
        if ($code -eq '204' -and $operation.responses[$code].content.Count -gt 0) { throw "204 must not have a body: $path" }
        if ($code -ne '204' -and !$operation.responses[$code].content['application/json']) { throw "Missing JSON response: $path" }
        if (!$operation.responses['500'].content['application/problem+json']) { throw "Missing safe 500: $path" }
        foreach ($response in $operation.responses.Values) {
            if ([string]::IsNullOrWhiteSpace($response.description)) { throw "Missing response description: $path" }
        }
        $secured = $path -like '/api/admin/*' -or $path -like '/api/cart*' -or $path -like '/api/orders*' -or $path -eq '/api/auth/me'
        if ($secured -and (!$operation.responses['401'] -or !$operation.security)) { throw "Missing JWT metadata: $path" }
        if ($secured -and $path -ne '/api/auth/me' -and !$operation.responses['403']) { throw "Missing role response: $path" }
        if (!$secured -and $operation.security) { throw "Public endpoint marked protected: $path" }
        $count++
    }
}
if ($count -ne 41) { throw 'Unexpected API operation count' }
foreach ($path in @('/api/auth/login','/api/auth/register')) {
    if (!$document.paths[$path].post.responses['429']) { throw "Missing auth rate limit: $path" }
}
foreach ($check in @(
    @{path='/api/products?page=0';status=400;validation=$true},
    @{path='/api/products/2147483647';status=404},
    @{path='/api/not-a-real-route';status=404},
    @{path='/api/cart';status=401},
    @{path='/api/admin/dashboard';status=401}
)) {
    $response=Invoke-WebRequest "$base$($check.path)" -SkipCertificateCheck -SkipHttpErrorCheck
    $problem=ReadJson $response
    if ($response.StatusCode -ne $check.status -or $problem.status -ne $check.status -or !$problem.title) { throw "Wrong error response: $($check.path)" }
    if ([string]$response.Headers['Content-Type'] -notlike 'application/problem+json*') { throw 'Wrong error media type' }
    if ($check.validation -and !$problem.errors) { throw 'Missing validation errors' }
}
"PASS: $count OpenAPI operations, success/204 bodies, auth metadata, 429/500 documentation and runtime 400/401/404 JSON errors."

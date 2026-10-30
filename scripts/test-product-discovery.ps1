# Read-only checks against the local API. No database changes.
$ErrorActionPreference='Stop'
$base='https://localhost:7044/api/products'
function ReadProducts($query) { Invoke-RestMethod "$base`?$query" -SkipCertificateCheck }
$all=ReadProducts 'pageSize=100&sortBy=id'
if ($all.total -gt 100) { throw 'This small-demo check expects at most 100 products.' }
$asc=ReadProducts 'pageSize=100&sortBy=priceAsc'
$desc=ReadProducts 'pageSize=100&sortBy=priceDesc'
foreach ($test in @(@{result=$asc;descending=$false},@{result=$desc;descending=$true})) {
    $last=$null; $seenNull=$false
    foreach ($item in $test.result.items) {
        if ($null -eq $item.minPrice) { $seenNull=$true; continue }
        if ($seenNull) { throw 'Products without price must be last.' }
        if ($null -ne $last -and (($test.descending -and $item.minPrice -gt $last) -or (!$test.descending -and $item.minPrice -lt $last))) { throw 'Price ordering failed.' }
        $last=$item.minPrice
    }
}
$newest=ReadProducts 'pageSize=100&sortBy=newest'
$expected=@($all.items.id | Sort-Object -Descending)
if (($newest.items.id -join ',') -ne ($expected -join ',')) { throw 'Newest ordering failed' }
$inStock=ReadProducts 'pageSize=100&sortBy=priceAsc&inStockOnly=true'
if ($inStock.total -ne @($all.items | Where-Object stockQuantity -gt 0).Count -or @($inStock.items | Where-Object stockQuantity -le 0).Count -gt 0) { throw 'Stock filter failed' }
$first=ReadProducts 'pageSize=3&sortBy=priceAsc&page=1'
$second=ReadProducts 'pageSize=3&sortBy=priceAsc&page=2'
$joined=@($first.items.id)+@($second.items.id)
if (($joined -join ',') -ne (($asc.items | Select-Object -First 6).id -join ',')) { throw 'Sorted pagination failed' }
$name=ReadProducts 'pageSize=100&sortBy=name'
if ($name.total -ne $all.total) { throw 'Name sorting changed count' }
if ($all.total -gt 0) {
    $category=$all.items[0].categoryId
    $combined=ReadProducts "pageSize=100&sortBy=priceDesc&inStockOnly=true&categoryId=$category"
    if (@($combined.items | Where-Object { $_.categoryId -ne $category -or $_.stockQuantity -le 0 }).Count) { throw 'Combined filters failed' }
}
foreach ($query in @('sortBy=unsupported','inStockOnly=invalid','sortBy=priceAsc&page=0')) {
    $r=Invoke-WebRequest "$base`?$query" -SkipCertificateCheck -SkipHttpErrorCheck
    if ($r.StatusCode -ne 400) { throw "Expected 400 for $query" }
}
'PASS: price/newest/name ordering, stock filter, combined category filter, stable pagination and validation.'

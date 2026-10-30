# PowerShell 7. Uses isolated synthetic users/product and cleans only this run's records.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'get-admin-test-headers.ps1')
$base = 'https://localhost:7044'
$marker = 'synthetic-commerce-' + [guid]::NewGuid().ToString('N')
$emails = @("$marker-1@example.test", "$marker-2@example.test")
$productId = 0
function Request($method, $path, $body, $headers, $expected) {
    $options = @{ Uri="$base$path"; Method=$method; SkipCertificateCheck=$true; SkipHttpErrorCheck=$true }
    if ($headers) { $options.Headers=$headers }
    if ($null -ne $body) { $options.Body=$body | ConvertTo-Json -Depth 10; $options.ContentType='application/json' }
    $r = Invoke-WebRequest @options
    if ([int]$r.StatusCode -ne $expected) { throw "$method $path expected $expected, got $($r.StatusCode): $($r.Content)" }
    if ($r.Content) { return $r.Content | ConvertFrom-Json }
}
function EditVariant($variantId, $stock, $price) {
    $detail=Request GET "/api/admin/products/$productId" $null $adminHeaders 200
    $v=$detail.variants | Where-Object id -eq $variantId
    $null=Request PUT "/api/admin/products/$productId/variants/$variantId" @{sku=$v.sku;size=$v.size;color=$v.color;price=$price;stockQuantity=$stock;isActive=$true;rowVersion=$v.rowVersion} $adminHeaders 200
}
function Stock($variantId) {
    $detail=Request GET "/api/admin/products/$productId" $null $adminHeaders 200
    return ($detail.variants | Where-Object id -eq $variantId).stockQuantity
}
function CheckoutBody { @{requestId=[guid]::NewGuid().ToString();recipientName='Synthetic recipient';phone='0900000000';address='Synthetic test address'} }
try {
    $baseline=Request GET '/api/admin/dashboard' $null $adminHeaders 200
    $null=Request GET '/api/admin/dashboard' $null $null 401
    $headers=@()
    foreach ($email in $emails) {
        $pw=[Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(24))+'Aa1!'
        $null=Request POST '/api/auth/register' @{email=$email;password=$pw;fullName=$marker} $null 201
        $login=Request POST '/api/auth/login' @{email=$email;password=$pw} $null 200
        $headers+=@{Authorization="Bearer $($login.accessToken)"}
    }
    $a=$headers[0]; $b=$headers[1]
    $null=Request GET '/api/admin/customers' $null $null 401
    $null=Request GET '/api/admin/customers' $null $a 403
    $customers=Request GET "/api/admin/customers?search=$marker" $null $adminHeaders 200
    if ($customers.total -ne 2) { throw 'Customer search failed' }
    $customerMe=Request GET '/api/auth/me' $null $a 200
    $customerId=$customerMe.id
    $otherMe=Request GET '/api/auth/me' $null $b 200
    $null=Request GET '/api/admin/customers/nonexistent-synthetic-id' $null $adminHeaders 404
    $null=Request GET '/api/admin/customers?pageSize=101' $null $adminHeaders 400
    $null=Request GET '/api/admin/dashboard' $null $a 403
    $null=Request GET '/api/admin/products/1/images' $null $a 403
    $null=Request GET '/api/admin/products/1/images' $null $null 401
    $lookups=Request GET '/api/admin/products/lookups' $null $adminHeaders 200
    $product=@{name=$marker;description='synthetic commerce test';categoryId=$lookups.categories[0].id;brandId=$lookups.brands[0].id;isActive=$true}
    $created=Request POST '/api/admin/products' $product $adminHeaders 201
    $productId=[int]$created.id
    $v1=Request POST "/api/admin/products/$productId/variants" @{sku="$marker-1";size='M';color='Black';price=100000;stockQuantity=5;isActive=$true} $adminHeaders 201
    $v2=Request POST "/api/admin/products/$productId/variants" @{sku="$marker-2";size='L';color='Black';price=200000;stockQuantity=1;isActive=$true} $adminHeaders 201
    $null=Request GET '/api/cart' $null $null 401
    $null=Request GET '/api/admin/orders' $null $a 403
    $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=0} $a 400
    $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=99} $a 409
    $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=2} $a 204
    $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=2} $a 204
    $cart=Request GET '/api/cart' $null $a 200
    if ($cart.items.Count -ne 1 -or $cart.items[0].quantity -ne 2 -or (Stock $v1.id) -ne 5) { throw 'Cart changed stock or repeated PUT added units' }
    $other=Request GET '/api/cart' $null $b 200
    if ($other.items.Count -ne 0) { throw 'Cart ownership leak' }
    $null=Request PUT "/api/cart/items/$($v2.id)" @{quantity=1} $a 204
    EditVariant $v2.id 0 200000
    $null=Request POST '/api/orders' (CheckoutBody) $a 409
    if ((Stock $v1.id) -ne 5) { throw 'Failed checkout partly reduced stock' }
    $cart=Request GET '/api/cart' $null $a 200
    if ($cart.items.Count -ne 2) { throw 'Failed checkout cleared cart' }
    $null=Request DELETE "/api/cart/items/$($v2.id)" $null $a 204
    $null=Request POST '/api/orders' @{requestId=[guid]::Empty.ToString();recipientName='x';phone='invalid';address='x'} $a 400
    $checkout=CheckoutBody
    $order=Request POST '/api/orders' $checkout $a 201
    $replay=Request POST '/api/orders' $checkout $a 201
    if ($order.id -ne $replay.id -or (Stock $v1.id) -ne 3) { throw 'Checkout replay created order or deducted twice' }
    $cart=Request GET '/api/cart' $null $a 200
    if ($cart.items.Count -ne 0) { throw 'Successful checkout did not clear cart' }
    $null=Request POST '/api/orders' (CheckoutBody) $a 409
    $null=Request GET "/api/orders/$($order.id)" $null $b 404
    $null=Request POST "/api/orders/$($order.id)/cancel" $null $b 404
    $otherOrders=Request GET '/api/orders' $null $b 200
    if ($otherOrders.total -ne 0) { throw 'Order list ownership leak' }
    $product.name="$marker-renamed"
    $null=Request PUT "/api/admin/products/$productId" $product $adminHeaders 204
    EditVariant $v1.id 3 150000
    $snapshot=Request GET "/api/orders/$($order.id)" $null $a 200
    if ($snapshot.total -ne 200000 -or $snapshot.items[0].unitPrice -ne 100000 -or $snapshot.items[0].productName -ne $marker -or $snapshot.paymentMethod -ne 'COD') { throw 'Purchase snapshot changed' }
    $null=Request POST "/api/orders/$($order.id)/cancel" $null $a 204
    $null=Request POST "/api/orders/$($order.id)/cancel" $null $a 204
    if ((Stock $v1.id) -ne 5) { throw 'Repeated cancellation restored stock twice' }
    'PASS: cart ownership, quantity/stock validation, rollback, checkout replay, snapshots, cancel once.'
    $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=1} $a 204
    $second=Request POST '/api/orders' (CheckoutBody) $a 201
    $detail=Request GET "/api/admin/orders/$($second.id)" $null $adminHeaders 200
    $null=Request PUT "/api/admin/orders/$($second.id)/status" @{status='Completed';rowVersion=$detail.rowVersion} $adminHeaders 409
    $oldVersion=$detail.rowVersion
    $null=Request PUT "/api/admin/orders/$($second.id)/status" @{status='Confirmed';rowVersion=$detail.rowVersion} $adminHeaders 204
    $null=Request PUT "/api/admin/orders/$($second.id)/status" @{status='Shipping';rowVersion=$oldVersion} $adminHeaders 409
    $null=Request POST "/api/orders/$($second.id)/cancel" $null $a 409
    foreach ($state in @('Shipping','Completed')) {
        $detail=Request GET "/api/admin/orders/$($second.id)" $null $adminHeaders 200
        $null=Request PUT "/api/admin/orders/$($second.id)/status" @{status=$state;rowVersion=$detail.rowVersion} $adminHeaders 204
    }
    $detail=Request GET "/api/admin/orders/$($second.id)" $null $adminHeaders 200
    $null=Request PUT "/api/admin/orders/$($second.id)/status" @{status='Cancelled';rowVersion=$detail.rowVersion} $adminHeaders 409
    $dashboard=Request GET '/api/admin/dashboard' $null $adminHeaders 200
    if ($dashboard.completedRevenue -ne ($baseline.completedRevenue + 150000) -or
        $dashboard.totalOrders -ne ($baseline.totalOrders + 2) -or
        $dashboard.ordersByStatus.Completed -ne ($baseline.ordersByStatus.Completed + 1) -or
        $dashboard.ordersByStatus.Cancelled -ne ($baseline.ordersByStatus.Cancelled + 1) -or
        $dashboard.totalProducts -ne ($baseline.totalProducts + 1) -or
        $dashboard.lowStockCount -ne ($baseline.lowStockCount + 2)) { throw 'Dashboard aggregates failed' }
    'PASS: dashboard authorization, completed revenue excludes cancelled orders, order counts and low-stock counts.'
    'PASS: ordered admin transitions, stale version rejection, completed order cannot cancel.'
    $profile=Request GET "/api/admin/customers/$customerId" $null $adminHeaders 200
    if ($profile.orderCount -ne 2 -or $profile.completedOrderCount -ne 1 -or $profile.completedSpend -ne 150000) { throw 'Customer purchase totals failed' }
    $history=Request GET "/api/admin/customers/$customerId/orders?pageSize=1" $null $adminHeaders 200
    if ($history.total -ne 2 -or $history.items.Count -ne 1) { throw 'Customer order pagination failed' }
    $emptyHistory=Request GET "/api/admin/customers/$($otherMe.id)/orders" $null $adminHeaders 200
    if ($emptyHistory.total -ne 0) { throw 'Customer order isolation failed' }
    if ($profile.PSObject.Properties.Name -contains 'passwordHash') { throw 'Sensitive field exposed' }
    'PASS: customer search, authorization, purchase totals, paged history, empty history and safe profile fields.'
    # Both customers see the last unit as available before simultaneous checkout.
    EditVariant $v1.id 1 150000
    foreach ($h in @($a,$b)) { $null=Request PUT "/api/cart/items/$($v1.id)" @{quantity=1} $h 204 }
    $handler=[Net.Http.HttpClientHandler]::new()
    $handler.ServerCertificateCustomValidationCallback=[Net.Http.HttpClientHandler]::DangerousAcceptAnyServerCertificateValidator
    $client=[Net.Http.HttpClient]::new($handler)
    try {
        $tasks=@()
        foreach ($h in @($a,$b)) {
            $message=[Net.Http.HttpRequestMessage]::new([Net.Http.HttpMethod]::Post,"$base/api/orders")
            $message.Headers.TryAddWithoutValidation('Authorization',$h.Authorization) | Out-Null
            $message.Content=[Net.Http.StringContent]::new(((CheckoutBody)|ConvertTo-Json),[Text.Encoding]::UTF8,'application/json')
            $tasks+=,$client.SendAsync($message)
        }
        $codes=@($tasks | ForEach-Object { [int]$_.GetAwaiter().GetResult().StatusCode } | Sort-Object)
        if (($codes -join ',') -ne '201,409' -or (Stock $v1.id) -ne 0) { throw "Concurrent last-unit checkout failed: $codes" }
    }
    finally { $client.Dispose(); $handler.Dispose() }
    'PASS: simultaneous checkout of last unit: one success, one conflict, stock zero.'
}
finally {
    $query=@"
SET XACT_ABORT ON;
IF DB_NAME() <> N'GenZFashionDb' OR CONVERT(nvarchar(128),SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS' THROW 50000,'Unexpected target',1;
BEGIN TRANSACTION;
DELETE oi FROM dbo.OrderItems oi JOIN dbo.Orders o ON oi.OrderId=o.Id JOIN dbo.AspNetUsers u ON o.UserId=u.Id WHERE u.Email IN (N'$($emails[0])',N'$($emails[1])') AND u.FullName=N'$marker';
DELETE o FROM dbo.Orders o JOIN dbo.AspNetUsers u ON o.UserId=u.Id WHERE u.Email IN (N'$($emails[0])',N'$($emails[1])') AND u.FullName=N'$marker';
DELETE c FROM dbo.Carts c JOIN dbo.AspNetUsers u ON c.UserId=u.Id WHERE u.Email IN (N'$($emails[0])',N'$($emails[1])') AND u.FullName=N'$marker';
DELETE FROM dbo.AspNetUsers WHERE Email IN (N'$($emails[0])',N'$($emails[1])') AND FullName=N'$marker';
IF EXISTS(SELECT 1 FROM dbo.Products WHERE Id=$productId AND Name IN(N'$marker',N'$marker-renamed'))
BEGIN
DELETE FROM dbo.ProductVariants WHERE ProductId=$productId;
DELETE FROM dbo.Products WHERE Id=$productId;
END;
COMMIT;
"@
    & sqlcmd -S 'KHANHS\SQLEXPRESS' -E -N -C -I -d GenZFashionDb -b -Q $query
    if ($LASTEXITCODE -ne 0) { throw 'Commerce test cleanup failed' }
}

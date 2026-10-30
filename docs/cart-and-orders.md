# Giỏ hàng và đơn hàng COD

Đã áp dụng migration `AddCartAndOrders` vào riêng `KHANHS\SQLEXPRESS / GenZFashionDb`.

## Hiểu bốn bảng mới

- `Carts`: mỗi Customer có tối đa một giỏ hàng, tạo khi thêm món đầu tiên.
- `CartItems`: một dòng cho mỗi biến thể trong giỏ, gồm số lượng 1–99; tối đa 50 dòng mỗi giỏ.
- `Orders`: chủ đơn, người nhận, số điện thoại, địa chỉ, tổng tiền, trạng thái, RequestId và thời gian UTC.
- `OrderItems`: ảnh chụp thông tin lúc mua: tên sản phẩm, SKU, size, màu, đơn giá, số lượng. Không đọc giá hiện tại để tính lại đơn cũ.

Phương thức thanh toán chỉ COD, phí vận chuyển bằng 0, tổng tiền là tổng đơn giá lúc mua nhân số lượng. Chưa có giảm giá hoặc quy trình trả hàng.

## Luồng Customer

Đăng ký/đăng nhập để nhận JWT có quyền Customer; admin riêng không có quyền mua hàng trong luồng này.

1. `GET /api/products`: chọn sản phẩm.
2. `GET /api/products/{id}`: lấy ID biến thể trong `variants`.
3. `PUT /api/cart/items/{variantId}` với `{"quantity":2}`: đặt số lượng chính xác bằng 2. Gửi lại không cộng thêm 2.
4. `GET /api/cart`: xem giỏ, tồn kho hiện tại, cờ `isAvailable` và tổng tiền ước tính. Thêm vào giỏ không trừ hoặc giữ hàng.
5. `DELETE /api/cart/items/{variantId}`: bỏ món; bỏ lại món đã không còn vẫn trả 204.
6. `POST /api/orders`: đặt toàn bộ giỏ với thông tin người nhận:

```json
{
  "requestId": "a72bfb3e-eaf1-42f4-b13e-e80410446151",
  "recipientName": "Khách thử nghiệm synthetic",
  "phone": "0900000000",
  "address": "Địa chỉ giả lập để kiểm thử"
}
```

Mỗi đơn mới dùng GUID RequestId mới. Nếu gửi lại cùng một lần đặt hàng do mất kết nối, giữ nguyên RequestId: API trả ID đơn đã tạo, không trừ tồn lần nữa. Giữ nguyên cả nội dung khi retry. Cùng RequestId đã tạo luôn trỏ về đơn cũ, không chỉnh sửa thông tin đơn theo payload mới.

Server kiểm tra lại trạng thái bán, giá và tồn kho. Client không gửi giá/tổng tiền. Tạo đơn, trừ tồn và xóa các món khỏi giỏ nằm trong cùng giao dịch database; bất kỳ món nào lỗi thì không lưu phần còn lại.

- `GET /api/orders?page=1&pageSize=10`: lịch sử chỉ của tài khoản hiện tại.
- `GET /api/orders/{id}`: chi tiết chỉ của chủ đơn; người khác nhận 404.
- `POST /api/orders/{id}/cancel`: Customer hủy đơn Pending của mình. Hủy lại đơn đã Cancelled không hoàn tồn thêm.

## Luồng Admin

- `GET /api/admin/orders`: tất cả đơn, hỗ trợ page/pageSize và `status=Pending` (hoặc trạng thái hợp lệ khác).
- `GET /api/admin/orders/{id}`: chi tiết gồm `rowVersion`.
- `PUT /api/admin/orders/{id}/status`: gửi `status` và `rowVersion` mới nhất từ chi tiết.

```json
{
  "status": "Confirmed",
  "rowVersion": "BASE64_FROM_LATEST_ORDER_DETAIL"
}
```

Trình tự: Pending → Confirmed → Shipping → Completed. Admin có thể hủy Pending hoặc Confirmed; Shipping/Completed không được hủy trong demo này. Cancelled không mở lại được. Admin chuyển trạng thái với rowVersion cũ nhận 409 và cần tải lại.

Cancelled hoàn tồn đúng một lần trong cùng giao dịch đổi trạng thái. Serializability, rowversion và ràng buộc database bảo vệ khi có yêu cầu đồng thời. Xung đột/deadlock trả 409 để client tải lại và thử lại; khi retry checkout phải giữ RequestId cũ. Một giao dịch thất bại không để lại tồn kho âm hoặc đơn nửa chừng.

## Kiểm thử tự động

Chạy API bằng profile https, rồi dùng PowerShell 7 ở thư mục solution:

```powershell
pwsh -NoProfile -File scripts/test-backend-isolated.ps1
```

Script khởi tạo admin synthetic tạm, hai Customer và một sản phẩm synthetic riêng để kiểm tra, sau đó dọn đúng các bản ghi của lần chạy. Không đặt lại mật khẩu admin thật. Script còn chạy lại kiểm thử catalog/danh mục/thương hiệu. Chỉ dùng trên database local GenZFashionDb.

Đã kiểm chứng: phân quyền và chủ đơn; kiểm tra số lượng; thêm giỏ không trừ tồn; thiếu hàng không lưu đơn hoặc trừ tồn một phần; giỏ chỉ xóa khi thành công; gửi lại RequestId không tạo trùng; snapshot giá/tên; hủy hai lần chỉ hoàn một lần; chuyển trạng thái sai/rowversion cũ bị chặn; hai khách đồng thời mua chiếc cuối có đúng một đơn thành công và tồn kho về 0.

## Xem trong SSMS

```sql
USE GenZFashionDb;
SELECT * FROM dbo.Carts;
SELECT * FROM dbo.CartItems;
SELECT * FROM dbo.Orders;
SELECT * FROM dbo.OrderItems;
SELECT * FROM dbo.__EFMigrationsHistory;
```

Sau kiểm thử tự động, các bảng mới có thể trống vì dữ liệu test đã được dọn. Migration vẫn có `AddCartAndOrders`; đây là kết quả bình thường. Chưa seed đơn hàng demo lâu dài ở bước này.

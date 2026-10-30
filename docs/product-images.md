# Ảnh sản phẩm bằng URL

Migration AddProductImages thêm bảng ProductImages vào GenZFashionDb. Mỗi ảnh gồm ProductId, Url (tối đa 2048 ký tự), AltText (mô tả, tối đa 200 ký tự) và SortOrder (số nguyên không âm). Ảnh dùng chung cho sản phẩm, chưa gắn theo màu/biến thể.

API admin yêu cầu JWT có quyền Admin:

- GET /api/admin/products/{productId}/images: xem ảnh theo thứ tự.
- POST /api/admin/products/{productId}/images: thêm URL ảnh.
- PUT /api/admin/products/{productId}/images/{imageId}: sửa URL, mô tả và thứ tự.
- DELETE /api/admin/products/{productId}/images/{imageId}: xóa bản ghi URL, không xóa file tại nguồn bên ngoài.

Ví dụ payload POST/PUT:

```json
{
  "url": "https://example.com/path/to/photo.jpg",
  "altText": "Áo thun đen nhìn từ phía trước",
  "sortOrder": 0
}
```

URL ví dụ là chỗ giữ chỗ, không phải ảnh thật. Thay bằng URL trực tiếp đến ảnh bạn được phép dùng. Nhận URL HTTPS tuyệt đối và không chứa username/password; từ chối HTTP, javascript và đường dẫn tương đối. Backend không tải hoặc kiểm tra nội dung ảnh từ URL. URL hợp lệ vẫn có thể trả 404, không phải ảnh hoặc bị nhà cung cấp chặn hotlink. Không cần tất cả sản phẩm có ảnh ngay.

Trong Swagger: đăng nhập Admin → Authorize → AdminProductImages → nhập productId lấy từ danh sách sản phẩm → POST → Execute (201). GET danh sách ảnh hoặc GET /api/products/{id} để kiểm tra. PUT/DELETE thành công trả 204; ảnh không thuộc đúng sản phẩm hoặc sản phẩm không tồn tại trả 404.

GET /api/products trả imageUrl: URL ảnh đầu tiên theo SortOrder rồi Id. Khi chưa có ảnh trả null. GET chi tiết sản phẩm (Customer và Admin) trả mảng images đã sắp xếp; không có ảnh trả []. Xóa ảnh đầu tiên thì ảnh kế tiếp thành ảnh đại diện. Frontend sau này cần hiển thị ảnh mặc định khi URL trống hoặc tải ảnh thất bại.

Đã kiểm thử HTTPS validation, thêm/sửa/xóa ảnh, thứ tự khi trùng SortOrder, ảnh đại diện/fallback, sản phẩm chưa có ảnh, giới hạn theo đúng productId, 401/403 và hồi quy COD/dashboard/catalog bằng scripts/test-backend-isolated.ps1. URL ảnh kiểm thử dùng example.test và không được tải về, không phải dữ liệu ảnh để trưng bày. Bản ghi kiểm thử đã được dọn; chưa thêm URL demo lâu dài.

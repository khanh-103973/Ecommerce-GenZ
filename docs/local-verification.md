# Kiểm chứng bản local — 30/10/2026

## Kết quả đã chạy

- `dotnet build GenZFashion.slnx --no-restore`: thành công, 0 lỗi/0 cảnh báo.
- `npm run build` trong `GenZFashion.Web`: thành công.
- API profile https chạy được; `/health/database`, `/openapi/v1.json`, `/swagger/index.html` trả 200. Giỏ hàng và dashboard chưa đăng nhập trả 401.
- `scripts/test-product-discovery.ps1`: đạt sắp xếp giá/mới nhất/tên, lọc tồn kho, kết hợp danh mục, phân trang và validation.
- `scripts/test-backend-isolated.ps1`: đạt auth (Customer-only, mật khẩu yếu/trùng, JWT hết hạn, 401/403, khóa tạm), commerce, catalog/ảnh và danh mục/thương hiệu.
- Commerce đạt quyền sở hữu giỏ/đơn, kiểm tra số lượng/tồn kho, rollback, RequestId chống trùng, snapshot giá, hoàn tồn một lần, chuyển trạng thái và rowVersion, dashboard/khách hàng. Hai khách mua chiếc cuối: một 201, một 409, tồn về 0.
- Test ảnh đạt CRUD URL HTTPS, validation, thứ tự/ảnh đại diện, ảnh rỗng và phạm vi sản phẩm. Không kiểm tra nội dung ảnh từ xa.

## Giữ dữ liệu hiện có

Test dùng admin, khách hàng và sản phẩm synthetic có mã ngẫu nhiên riêng; không chạy repair/reset admin hoặc migration. Kiểm tra ràng buộc xóa danh mục/thương hiệu dùng sản phẩm synthetic riêng, không thử xóa bản ghi người dùng.

Sau khi dọn, số dòng và `CHECKSUM_AGG(BINARY_CHECKSUM(*))` của tất cả bảng trùng trước test: 20 sản phẩm, 80 biến thể, 4 danh mục, 1 thương hiệu, 1 ảnh, 1 đơn, 1 dòng đơn và 2 tài khoản. Checksum là kiểm tra đối chiếu, không phải bản backup hay chứng minh mật mã. Bộ đếm ID/rowversion của database có thể tăng do các thao tác synthetic.

## Phạm vi chưa kiểm tra trong lượt này

- Chưa kiểm thử lại giao diện trình duyệt/mobile hoặc toàn bộ form và route. Build frontend không thay thế kiểm thử giao diện.
- Chưa có test tự động .NET/frontend tích hợp CI. PowerShell integration tests hiện phụ thuộc Windows, SQL Server local và cấu hình phát triển.
- Chưa kết luận tối ưu truy vấn tải nhiều collection; chưa thay đổi cách truy vấn.
- Chưa triển khai Docker/Jenkins/cloud, kiểm tra cấu hình production hoặc backup/restore database.

Git lưu mã, migrations và hướng dẫn; không chứa dữ liệu SQL Server, User Secrets hoặc mật khẩu admin.

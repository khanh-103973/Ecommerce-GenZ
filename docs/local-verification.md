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

## Bổ sung kiểm thử giao diện cùng ngày

- Đã kiểm tra qua trình duyệt: đăng ký/đăng nhập, tạo sản phẩm và biến thể synthetic, thêm danh mục, tìm sản phẩm, chọn biến thể, chặn số lượng 0, thêm giỏ, đặt COD và hủy đơn Pending synthetic. Dashboard hiển thị tồn trở lại 3 sau hủy.
- Đã kiểm tra dashboard, bảng đơn admin, lọc Pending rỗng và tìm khách hàng synthetic.
- Đã thử viewport 390×844 cho menu customer, tìm kiếm, chi tiết sản phẩm, giỏ hàng, COD và form danh mục. Trang chi tiết đơn có scrollWidth bằng clientWidth, không tràn ngang.
- Đã sửa: đăng nhập lại quay về route đang xem theo quyền tài khoản; xác minh bằng reload tại giỏ hàng và danh mục admin. Token vẫn chỉ ở bộ nhớ.
- Đã sửa: form thêm danh mục/thương hiệu xóa nội dung sau thành công, giữ nội dung khi lỗi. Đã tái hiện và xác minh bản sửa qua form danh mục.
- `npm test`: 5 bài đạt cho route quay lại sau đăng nhập, query/fragment, quyền Customer/Admin, chặn URL ngoài và vòng lặp login. `npm run build` đạt sau sửa.
- Dữ liệu UI synthetic đã dọn; số dòng/checksum tất cả bảng khớp mốc trước chạy. Không đổi mật khẩu hoặc role của tài khoản thật.

## Sau khi tách frontend thành module

- `main.jsx` chỉ còn khởi tạo React; `App.jsx` giữ route. Đã tách context, hooks, components, layouts và pages; cập nhật Solution Folder để các tệp xuất hiện trong Visual Studio.
- Đối chiếu cả 36 khai báo của `main.jsx` trước tách với bản mới sau chuẩn hóa định dạng: khớp toàn bộ. CSS trước/sau chuẩn hóa cũng khớp; bản build giữ nguyên hash CSS. Đây là kiểm tra việc di chuyển/định dạng, không thay thế kiểm thử hành vi.
- `npm test` (5 bài), `npm run build`, `npm run format:check` đều đạt sau tách.
- Trình duyệt: trang chủ, tìm kiếm rỗng, xóa bộ lọc, giá tăng + còn hàng (19 sản phẩm), chi tiết/chọn biến thể, đăng ký synthetic và quay lại sản phẩm, giỏ rỗng, lịch sử đơn rỗng, đăng nhập/đăng xuất.
- Admin: dashboard, danh sách/chi tiết sản phẩm và các form biến thể/ảnh, danh sách/chi tiết đơn 7 (chỉ xem), tìm khách/hồ sơ, danh mục và thương hiệu đều hiển thị được.
- Lượt refactor chỉ tạo tài khoản synthetic rồi dọn; không đặt đơn, sửa sản phẩm, reset mật khẩu hoặc chạy migration. Chưa chạy lại toàn bộ thao tác ghi/COD qua UI sau tách; lượt kiểm thử UI trước đó ghi ở trên.

## Sau khi bổ sung metadata và xử lý lỗi API

- Cả 41 action nghiệp vụ khai báo mã thành công/lỗi liên quan; 204 không có schema/body hoặc mã 200 mặc định thừa. Giữ các phản hồi nghiệp vụ và payload thành công hiện có.
- Có middleware trả 500 ProblemDetails với thông báo chung và traceId; lỗi chưa có body dưới `/api` được bổ sung JSON. Xem [mã phản hồi API](api-responses.md) để biết phần còn dùng schema tổng quát và mẫu lỗi cũ.
- `scripts/test-api-contract.ps1`: đạt kiểm tra 41 action, metadata JWT, 204 không có body, 429/500 trong tài liệu và lỗi 400/401/404 thực tế.
- `scripts/test-api-failure-isolated.ps1`: đạt trên tiến trình Production tạm; 500 có JSON/traceId với JSON và HTML Accept, không chứa stack trace/chi tiết SQL; Swagger/OpenAPI/health Development bị ẩn; xen kẽ đăng ký/đăng nhập vượt giới hạn chung trả JSON 429. Không kết nối database thật.
- Đã chạy lại toàn bộ `scripts/test-backend-isolated.ps1`: auth, phân quyền, COD/rollback/replay/concurrency/hoàn tồn, dashboard/khách hàng, CRUD catalog/ảnh/lookups đều đạt.
- Sau khi dọn dữ liệu synthetic, số dòng/checksum của tất cả bảng khớp mốc trước bộ test. Build solution cuối đạt 0 lỗi/0 cảnh báo; API kiểm thử đã được dừng trước build.
- `npm test`: 10 bài đạt, gồm 5 bài điều hướng và 5 bài đọc lỗi/204 của frontend. Build frontend và kiểm tra định dạng đạt. Không chạy lại kiểm thử giao diện trình duyệt trong lượt thay đổi middleware này.

## Phạm vi còn lại

- Chưa kiểm tra đầy đủ mọi form/route, lỗi mạng, hết hạn token trong lúc thao tác hoặc cập nhật đồng thời qua UI. Chưa kiểm thử lại thao tác chuyển đơn admin đến Completed qua UI trong lượt này; luồng backend đã đạt ở bộ test phía trên.
- Chưa có test tự động .NET hoặc kiểm thử trình duyệt tích hợp CI. Frontend có 10 bài kiểm thử điều hướng/đọc lỗi bằng Node, chưa có bộ test component. PowerShell integration tests hiện phụ thuộc Windows, SQL Server local và cấu hình phát triển.
- Chưa kết luận tối ưu truy vấn tải nhiều collection; chưa thay đổi cách truy vấn.
- Chưa triển khai Docker/Jenkins/cloud, kiểm tra cấu hình production hoặc backup/restore database.

Git lưu mã, migrations và hướng dẫn; không chứa dữ liệu SQL Server, User Secrets hoặc mật khẩu admin.

# GenZ Fashion

Backend ASP.NET Core Web API (.NET 10), dùng controllers và SQL Server Express.
Repository: https://github.com/khanh-103973/Ecommerce-GenZ.git

## Hiện trạng và cách chạy ưu tiên (30/10/2026)

- Backend .NET 10 + EF Core + SQL Server; frontend React/Vite. Đã có catalog, Identity/JWT, giỏ hàng, COD, quản trị sản phẩm/ảnh/đơn/khách hàng và dashboard.
- Database có 4 migrations: InitialCatalog, AddIdentity, AddCartAndOrders, AddProductImages. Không xóa/tạo lại database; API không tự áp dụng migration khi khởi động.
- Mọi `/api/admin/*` yêu cầu JWT Admin trong cả Development và Production. Customer chỉ truy cập giỏ/đơn của mình.
- Backend: mở `GenZFashion.slnx` trong Visual Studio, chọn `GenZFashion.Api`, profile `https`, Ctrl+F5. Cần User Secrets local đã cấu hình, xem [authentication](docs/authentication.md).
- Frontend: mở `GenZFashion.Web` trong VS Code, chạy `npm ci` lần đầu (dừng Vite trước khi cài), rồi `npm run dev`. Truy cập http://127.0.0.1:5173; API chạy tại https://localhost:7044.
- Kiểm thử backend: khi API https đang chạy, dùng PowerShell 7 chạy `pwsh -NoProfile -File scripts/test-backend-isolated.ps1`. Bộ test tạo admin synthetic riêng, kiểm thử auth/commerce/catalog/lookups và dọn dữ liệu; không đổi mật khẩu admin thật. Không thao tác website đồng thời khi chạy kiểm thử thống kê.
- Kiểm thử chỉ đọc bộ lọc: `pwsh -NoProfile -File scripts/test-product-discovery.ps1`.
- Kết quả xác minh và giới hạn: [kiểm chứng bản local](docs/local-verification.md). Chưa triển khai cloud hoặc CI/CD.
- Mã phản hồi, nội dung lỗi và kiểm thử OpenAPI: [hướng dẫn phản hồi API](docs/api-responses.md).
- Git chỉ sao lưu mã nguồn; không sao lưu database và User Secrets. Máy khác cần cấu hình local riêng.

## Lịch sử thực hành

Các phần bên dưới ghi lại từng giai đoạn cũ; những câu như “chưa có entity”, “chưa có đăng nhập”, “admin chỉ chạy local” không còn là hiện trạng. Ưu tiên mục hiện trạng phía trên và các tài liệu trong `docs/`.

## Chạy local

1. Mở terminal tại thư mục chứa `GenZFashion.slnx`.
2. Chạy `dotnet tool restore` để khôi phục dotnet-ef 10.0.13 riêng cho dự án.
3. Chạy `dotnet restore` rồi `dotnet build`.
4. Chạy `dotnet run --project GenZFashion.Api --launch-profile https`.
5. Kiểm tra:
   - https://localhost:7044/weatherforecast: API mẫu trả về 5 bản ghi.
   - https://localhost:7044/openapi/v1.json: mô tả API trong môi trường Development.
   - https://localhost:7044/health/database: trả HTTP 200 và `{"status":"Connected"}` khi EF Core kết nối thành công; HTTP 503 khi không kết nối được. Chỉ có trong Development.

Có thể dùng file `GenZFashion.Api/GenZFashion.Api.http` để gửi request trong Visual Studio.
Nếu trình duyệt chưa tin cậy chứng chỉ phát triển, chạy `dotnet dev-certs https --trust`.

## Database local

- Máy chủ: `KHANHS\SQLEXPRESS`.
- Database riêng: `GenZFashionDb`.
- Windows Authentication: không lưu mật khẩu trong cấu hình.
- Chuỗi kết nối nằm trong `appsettings.Development.json`. `Encrypt=True;TrustServerCertificate=True` dành cho SQL Server local.
- `GenZFashionDbContext` là điểm EF Core quản lý các entity và truy vấn database; hiện chưa có entity/DbSet.
- Đã kiểm tra tên chưa tồn tại trước khi tạo database trống ngày 29/10/2026. Chưa tạo migration hoặc bảng nghiệp vụ.
- Không tự tạo hay cập nhật database khi API khởi động.
- Khi chạy môi trường khác, cung cấp `ConnectionStrings__GenZFashionDb` bằng cấu hình môi trường phù hợp. Không đưa mật khẩu/khóa vào Git.

## Migrations sau khi thống nhất thiết kế

Chỉ chạy sau khi đã thêm entity, kiểm tra đúng server/database và xem nội dung migration:

```powershell
$env:ASPNETCORE_ENVIRONMENT = 'Development'
dotnet ef migrations add InitialCreate --project GenZFashion.Api
dotnet ef migrations script --project GenZFashion.Api
dotnet ef database update --project GenZFashion.Api
```

Migration đầu tiên sẽ tạo các bảng theo thiết kế đã chốt và bảng lịch sử migrations trong database hiện có.
Không dùng `EnsureCreated` để thay thế migrations.

## Phiên bản

OpenAPI, EF Core SQL Server, EF Core Design và dotnet-ef: 10.0.13.
Tham chiếu trực tiếp `System.Security.Cryptography.Pkcs` 10.0.13 để thay bản 9.0.11 bị NuGet cảnh báo bảo mật trong chuỗi phụ thuộc SQL Client.

## Kết quả kiểm tra ngày 29/10/2026

- Build: 0 lỗi, 0 cảnh báo sau khi cập nhật thư viện phụ thuộc.
- EF CLI nhận đúng DbContext, provider SQL Server và database `GenZFashionDb`.
- HTTPS: WeatherForecast, OpenAPI và kiểm tra database đều trả HTTP 200.
- Database sau khi tạo có 0 bảng nghiệp vụ. Chưa triển khai lên cloud.

## Cập nhật bước catalog

Đã áp dụng migration InitialCatalog vào GenZFashionDb: Categories, Brands, Products, ProductVariants và __EFMigrationsHistory. Các mô tả database trống ở trên ghi nhận trạng thái trước bước này. Hiện các bảng catalog chưa có dữ liệu mẫu. Giá biến thể dùng VND nguyên; SKU và tổ hợp sản phẩm/size/màu là duy nhất; giá và tồn kho không âm. Chưa có API quản lý catalog.


## API catalog và dữ liệu mẫu

Đã thêm 20 sản phẩm, 80 biến thể, 4 danh mục và 1 thương hiệu có nhãn synthetic. Script scripts/seed-catalog.sql chỉ chạy trên KHANHS\SQLEXPRESS/GenZFashionDb và chỉ chèn khi catalog trống; chạy lại không sửa dữ liệu hiện có.

GET /api/products hỗ trợ search, categoryId, brandId, page (mặc định 1), pageSize (mặc định 10, tối đa 100). Kết quả gồm items, total, page, pageSize, totalPages. GET /api/products/{id} trả thông tin sản phẩm và biến thể đang bán; sản phẩm không tồn tại hoặc bị ẩn trả 404. Các API này chỉ đọc, dành cho customer; chưa có API ghi/admin hoặc đăng nhập.


## API quản trị catalog (bước local)

API quản trị hiện chỉ cho phép kết nối loopback trong môi trường Development. Đây là giới hạn tạm để thực hành; cần JWT và phân quyền Admin trước khi triển khai quản trị lên server. Không dùng Development hoặc proxy chuyển tiếp để công khai các API này.

- GET /api/admin/products: danh sách gồm sản phẩm đang bán và bị ẩn, có page/pageSize.
- GET /api/admin/products/lookups: danh mục/thương hiệu để chọn ID.
- GET /api/admin/products/{id}: chi tiết gồm cả biến thể bị ẩn và rowVersion.
- POST /api/admin/products: tạo sản phẩm.
- PUT /api/admin/products/{id}: thay toàn bộ thông tin sản phẩm, dùng isActive=false để ẩn.
- POST /api/admin/products/{id}/variants: thêm biến thể.
- PUT /api/admin/products/{id}/variants/{variantId}: sửa biến thể/giá/tồn kho/trạng thái; phải gửi rowVersion mới nhất.

ProductRequest và VariantRequest là các lớp nhận dữ liệu đầu vào, tách khỏi entity database. API kiểm tra tên, độ dài, ID liên quan, giá VND nguyên và tồn kho không âm. Trùng SKU hoặc size/màu trả 409. rowVersion giúp ngăn ghi đè thay đổi mới hơn khi sửa biến thể; khi nhận 409 cần tải lại và xem dữ liệu trước khi lưu lại. Thông tin chung sản phẩm hiện chưa có kiểm tra phiên bản đồng thời.

Mở GenZFashion.Api/AdminCatalog.http trong Visual Studio để thực hành. Thay ID bằng kết quả thật trước khi gửi. Chưa có API quản trị danh mục/thương hiệu hoặc ảnh ở bước này.

Kiểm thử tích hợp: chạy API profile https, rồi chạy `pwsh -NoProfile -File scripts/test-admin-catalog.ps1`. Script tạo sản phẩm synthetic riêng, kiểm thử validation/ẩn/concurrency và dọn đúng bản ghi test. Script chỉ dùng SQL Server local GenZFashionDb. Đã kiểm tra Production trả 404 cho API admin; sau kiểm thử còn 20 sản phẩm và 80 biến thể.

## Quản lý danh mục và thương hiệu

Đã bổ sung /api/admin/categories và /api/admin/brands. Mỗi nhóm có GET danh sách, GET /{id}, POST, PUT /{id}, DELETE /{id}. POST/PUT nhận JSON gồm name (bắt buộc, tối đa 100 ký tự); tên được loại khoảng trắng ở hai đầu. Tên trùng trả 409; dữ liệu sai trả 400; ID không tồn tại trả 404. Chỉ xóa được mục chưa có sản phẩm sử dụng, kể cả sản phẩm đang ẩn vẫn ngăn xóa. Không cần migration mới.

Tất cả controller admin dùng LocalDevelopmentOnlyAttribute, chặn truy cập ngoài Development/local trước khi kiểm tra request. Đây vẫn là giới hạn tạm thời, chưa thay thế JWT/phân quyền. Chạy `pwsh -NoProfile -File scripts/test-admin-lookups.ps1` khi API https đang chạy để kiểm thử; script dọn bản ghi test qua API. Đã chạy lại test catalog và kiểm tra Production chặn GET/POST của cả ba nhóm admin. Dữ liệu sau test: 4 danh mục, 1 thương hiệu, 20 sản phẩm, 80 biến thể.

## Trạng thái mới nhất: Identity + JWT

Đã áp dụng migration AddIdentity. Các API admin hiện yêu cầu JWT có vai trò Admin, thay thế giới hạn local/Development mô tả ở các phần lịch sử phía trên. Chưa đăng nhập trả 401; Customer trả 403; Admin được phép. Hướng dẫn đầy đủ: [đăng nhập và phân quyền](docs/authentication.md).

Cần User Secrets với Jwt:SigningKey để chạy local; Visual Studio → nhấn phải project → Manage User Secrets. Tài khoản admin local đã được tạo; không lưu bí mật vào Git. Các script test quản trị đã được cập nhật để đăng nhập lấy token. Đã kiểm thử đăng ký/đăng nhập, token hết hạn, khóa tạm, phân quyền và các thao tác catalog; đã kiểm tra JWT trong Production local. Dữ liệu còn 20 sản phẩm, 80 biến thể và 1 tài khoản Admin; tài khoản kiểm thử đã được dọn.

## Giỏ hàng và COD

Đã thêm Carts, CartItems, Orders, OrderItems bằng migration AddCartAndOrders. Xem [hướng dẫn giỏ hàng và đơn COD](docs/cart-and-orders.md) cho API, quy tắc trạng thái và cách thực hành. Đã kiểm thử giao dịch tồn kho, snapshot giá mua, quyền sở hữu đơn, chống đặt trùng, hoàn tồn một lần và hai khách mua chiếc cuối. Chạy scripts/test-backend-isolated.ps1 bằng PowerShell 7 khi API https đang chạy để kiểm thử bằng admin synthetic riêng; không đổi mật khẩu admin thật. Các đơn kiểm thử đã được dọn; chưa có đơn demo giữ lại.

## Swagger UI

Chạy API profile https trong Development rồi mở https://localhost:7044/swagger. Swagger UI dùng tài liệu /openapi/v1.json hiện có và hỗ trợ JWT qua nút Authorize. Gọi POST /api/auth/login, sao chép accessToken rồi dán vào Authorize (không thêm Bearer). Customer dùng giỏ hàng/đặt đơn, Admin dùng /api/admin/*. Khi đổi tài khoản, Logout trong hộp Authorize rồi nhập token mới. Token không được cấu hình lưu qua lần tải lại trang. Swagger chỉ bật trong Development; thao tác ghi trong Swagger thay đổi database thật của dự án.


## Dashboard admin

GET /api/admin/dashboard (JWT Admin) trả tổng sản phẩm, activeProducts/hiddenProducts, tổng đơn, ordersByStatus cho đầy đủ 5 trạng thái, completedRevenue (VND, chỉ đơn Completed), lowStockCount và tối đa 20 lowStockVariants. Ngưỡng sắp hết là tồn <=5, bao gồm hết hàng, chỉ tính biến thể và sản phẩm đang bán; sắp tồn tăng dần rồi ID. generatedAt dùng UTC. Đây là số liệu toàn thời gian, không phải doanh thu theo ngày, không phải lợi nhuận. Các truy vấn thống kê được đọc liên tiếp nên khi có thay đổi đồng thời có thể có chênh lệch tức thời; tải lại để cập nhật.

Không thêm bảng/migration. Đã kiểm thử 401/403, đếm sản phẩm/đơn, chỉ cộng doanh thu hoàn tất và tồn thấp trong scripts/test-commerce.ps1. Mở Swagger → đăng nhập Admin → Authorize → AdminDashboard → GET /api/admin/dashboard → Try it out → Execute.

## Ảnh sản phẩm

Đã thêm ProductImages và API quản trị URL ảnh. Xem [hướng dẫn ảnh sản phẩm](docs/product-images.md). Danh sách Customer trả imageUrl, chi tiết Customer/Admin trả images. Chỉ lưu URL HTTPS, không tải ảnh về server, không seed link ảnh giả. Sản phẩm không có ảnh vẫn hoạt động; frontend sẽ xử lý ảnh mặc định.


## Quản trị khách hàng

GET /api/admin/customers hỗ trợ search theo tên/email, page và pageSize (tối đa 100). Chỉ liệt kê tài khoản có vai trò Customer; không liệt kê Admin chỉ có quyền Admin. Trả id, fullName, email, orderCount (mọi trạng thái) và completedSpend (VND, chỉ đơn Completed).

GET /api/admin/customers/{id} trả hồ sơ cùng completedOrderCount. GET /api/admin/customers/{id}/orders trả lịch sử đơn có phân trang; dùng ID đơn để xem chi tiết tại /api/admin/orders/{id}. id khách hàng là chuỗi GUID lấy từ danh sách, không phải ID sản phẩm hoặc đơn hàng. Chưa có API sửa/xóa/khóa khách hàng ở bước này. Không trả PasswordHash, SecurityStamp hoặc token.

Trong Swagger: đăng nhập Admin → Authorize → nhóm AdminCustomers → GET danh sách → lấy id → GET chi tiết hoặc lịch sử đơn. Đã kiểm thử tìm kiếm, 401/403, 404, số đơn và chi tiêu, lịch sử trống và phân trang; không cần migration mới.

## Giao diện React

Đã thêm GenZFashion.Web với trang customer và admin kết nối API thật. Xem [hướng dẫn chạy frontend](docs/frontend.md). Mở http://127.0.0.1:5173 khi API https và npm run dev đang chạy. Không cần thử Swagger thủ công nữa. API công khai /api/catalog cung cấp danh mục/thương hiệu cho bộ lọc. Chưa triển khai lên server.

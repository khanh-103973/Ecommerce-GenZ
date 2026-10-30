# Giao diện React local

Frontend nằm trong GenZFashion.Web, dùng React, React Router, Vite và CSS responsive. API và SQL Server hiện có là nguồn dữ liệu thật. Không cần Swagger để thao tác mua hàng hoặc quản trị.

## Cập nhật điều hướng và form

Khi mở trang cần đăng nhập hoặc tải lại giỏ/đơn/trang admin, đăng nhập xong sẽ quay về route đó nếu tài khoản có quyền. Nếu đăng nhập bằng vai trò khác, ứng dụng về trang mặc định phù hợp. Token vẫn chỉ giữ trong bộ nhớ, không lưu vào trình duyệt.

Form thêm danh mục/thương hiệu xóa ô tên sau khi lưu thành công. Kiểm thử điều hướng chạy bằng `npm test` trong thư mục `GenZFashion.Web` (Node test runner, không cần cài thêm gói). Xem [phạm vi kiểm chứng giao diện](local-verification.md).

## Cấu trúc mã nguồn

`src/main.jsx` chỉ gắn React vào phần tử `root` và nạp CSS. `src/App.jsx` khai báo các route và chọn bố cục customer/admin.

- `context/AuthContext.jsx`: trạng thái tài khoản, đăng nhập, đăng xuất và thông báo hết phiên; mọi trang dùng cùng một context.
- `hooks/useData.js`: tải dữ liệu, loading/lỗi, hủy request khi đổi trang và tải lại. `hooks/useTask.jsx`: trạng thái khi gửi thao tác và thông báo kết quả.
- `components/`: kiểm tra quyền (`Guard`), trạng thái tải/lỗi, trường nhập, phân trang, badge, ảnh và thẻ sản phẩm.
- `layouts/`: header/footer cửa hàng và sidebar quản trị.
- `pages/`: trang chủ, bộ sưu tập, sản phẩm, đăng nhập và giỏ hàng.
- `pages/orders/`: danh sách/chi tiết đơn dùng chung cho customer và admin qua prop `admin`.
- `pages/admin/`: dashboard, sản phẩm/biến thể/ảnh, danh mục/thương hiệu và khách hàng.
- `api.js`: gọi API và định dạng giá/trạng thái. `auth-navigation.js`: chọn route sau đăng nhập, có kiểm thử riêng.

Ví dụ: muốn sửa ô SKU/tồn kho, đọc `pages/admin/ProductForms.jsx`; muốn sửa trang giỏ, đọc `pages/Cart.jsx`; muốn thêm hoặc xem route, đọc `App.jsx`. Frontend vẫn là Solution Folder trong Visual Studio, không phải project C#.

Công cụ Prettier chỉ phục vụ phát triển, được ghim phiên bản trong package/lockfile. Chạy `npm run format` để định dạng `src`, hoặc `npm run format:check` để chỉ kiểm tra. Không đổi nghiệp vụ khi tách mã.

## Chạy ứng dụng

Cách nhanh trên máy đã cài .NET và Node: nhấp đúp `Chay-GenZFashion.cmd` ở thư mục solution. File mở hai cửa sổ API/Web và trình duyệt. Đợi hai cửa sổ báo chạy xong rồi tải lại trang nếu cần. Không chạy thêm bản khác khi hai cửa sổ đang hoạt động. Dừng bằng Ctrl+C trong từng cửa sổ. Nếu dùng Visual Studio chạy API rồi thì chỉ chạy npm run dev riêng, không dùng launcher để tránh trùng cổng.

Mở terminal thứ nhất tại thư mục solution:

```powershell
dotnet run --project GenZFashion.Api --launch-profile https
```

Mở terminal thứ hai:

```powershell
cd GenZFashion.Web
npm ci
npm run dev
```

Chỉ cần npm ci khi chưa cài dependencies hoặc package-lock.json thay đổi. Trình duyệt mở http://127.0.0.1:5173. Giữ hai terminal chạy; Ctrl+C để dừng từng terminal.

Vite chuyển tiếp /api đến https://localhost:7044. secure:false chỉ cho kết nối proxy dev với chứng chỉ tự ký local; không dùng thiết lập này để triển khai production. Frontend không cần chứa khóa JWT hay chuỗi kết nối database.

## Customer

- /: trang chủ, bộ sưu tập.
- /shop: danh sách, tìm kiếm, lọc danh mục/thương hiệu và phân trang.
- /products/{id}: ảnh, mô tả, chọn biến thể size/màu và số lượng. Nút thêm giỏ đặt số lượng chính xác, không cộng thêm vào số cũ.
- /login: đăng nhập hoặc đăng ký. Customer chuyển đến bộ sưu tập, Admin chuyển đến quản trị.
- /cart: tăng/giảm số lượng, bỏ món, nhập người nhận, đặt COD.
- /orders và /orders/{id}: lịch sử, chi tiết và hủy đơn Pending.

Đơn hàng/giỏ hàng dành cho tài khoản có quyền Customer. Admin không tự có quyền mua hàng. Mỗi lần đặt đơn dùng RequestId riêng; retry cùng yêu cầu dùng lại ID để tránh tạo trùng.

## Admin

- /admin: dashboard số liệu thật.
- /admin/products: danh sách và thêm sản phẩm; vào chi tiết để sửa thông tin, quản lý biến thể/tồn kho và URL ảnh.
- /admin/orders: lọc trạng thái, chi tiết, xác nhận/giao/hoàn tất/hủy theo quy tắc backend. Giao diện tự gửi rowVersion; người dùng không cần chép mã này.
- /admin/customers: tìm khách và lịch sử mua.
- /admin/categories, /admin/brands: thêm/sửa/xóa mục chưa được sử dụng.

Đăng nhập bằng tài khoản admin local đã thiết lập trong User Secrets. Không lưu mật khẩu vào mã frontend. Token hiện chỉ giữ trong bộ nhớ; tải lại trang hoặc đóng tab thì đăng nhập lại. Token hết hạn trả người dùng về trạng thái chưa đăng nhập. Giới hạn quyền vẫn do backend quyết định.

## Thiết kế và ảnh

Định hướng theo các ảnh tham khảo: trang customer phong cách chữ lớn đen/trắng với xanh lime, admin có sidebar và thẻ số liệu đơn giản. Đây là bản đầu phục vụ thực hành, không sao chép toàn bộ ảnh mẫu. Sản phẩm thiếu ảnh hoặc URL hỏng dùng hình SVG minh họa, có nhãn rõ ràng; URL ảnh thật vẫn được hiển thị khi tải được. Chưa có đánh giá, wishlist hoặc thanh toán online.

## Build và kiểm chứng

```powershell
npm run build
```

Đã kiểm tra trực tiếp trình duyệt: tải dữ liệu catalog qua proxy; đăng ký/đăng nhập Customer; tìm sản phẩm; chọn biến thể; thêm giỏ và đặt COD; đăng nhập Admin; xem dashboard; xử lý đơn tới Completed; sửa sản phẩm và tồn kho. Dữ liệu synthetic riêng đã được dọn, đơn thực hành 7 giữ nguyên. Đã kiểm tra bố cục màn hình nhỏ 390px và sửa nút đăng xuất admin trên mobile. Giao diện có trạng thái tải, rỗng, lỗi và nút thử lại.

Build tạo dist (đã bỏ qua trong Git). Chưa triển khai frontend; khi làm Docker/Nginx cần cấu hình phục vụ SPA fallback về index.html và proxy /api tới backend. Không dùng Vite dev server làm máy chủ production.

## Sắp xếp và lọc tồn kho

Trang /shop có Mới nhất, Giá thấp đến cao, Giá cao đến thấp, Tên sản phẩm A–Z và Chỉ hiện sản phẩm còn hàng. Đổi lựa chọn đưa phân trang về trang 1; Xóa bộ lọc đặt lại toàn bộ bộ lọc. Sắp xếp theo giá dùng giá thấp nhất trong các biến thể đang bán (có thể gồm biến thể hết hàng); bộ lọc còn hàng yêu cầu ít nhất một biến thể đang bán có tồn >0. Mới nhất dựa theo ID sản phẩm giảm dần. Sản phẩm chưa có biến thể/giá đứng cuối khi sắp xếp giá. Thứ tự luôn có ID làm tiêu chí phụ để phân trang ổn định. Backend xử lý trước khi phân trang; mặc định API không truyền sortBy vẫn theo ID tăng dần để tương thích.

Kiểm thử chỉ đọc: pwsh -NoProfile -File scripts/test-product-discovery.ps1. Đã kiểm tra backend và trực tiếp trên React: lọc còn 19 sản phẩm và giá tăng từ 160.000đ với dữ liệu demo hiện tại. Không sửa database ở bước này.

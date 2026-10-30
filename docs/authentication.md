# Đăng nhập và phân quyền

Trạng thái hiện tại: Identity + JWT đã thay thế giới hạn admin chỉ dùng local Development. Tất cả `/api/admin/*` yêu cầu vai trò Admin trong cả Development và Production. Các đoạn README ghi admin chỉ chạy local mô tả giai đoạn trước.

## Các API

- `POST /api/auth/register`: nhận `email`, `password`, `fullName`; luôn tạo Customer. Thành công trả 201. Email trùng hoặc mật khẩu yếu trả 400 (trùng khi có yêu cầu đồng thời có thể trả 409).
- `POST /api/auth/login`: nhận `email`, `password`; thành công trả `accessToken`, `tokenType`, `expiresAt`. Token có hiệu lực 30 phút.
- `GET /api/auth/me`: gửi header `Authorization: Bearer <accessToken>` để xem hồ sơ và vai trò.
- `/api/products` vẫn cho phép xem không cần đăng nhập.

401 nghĩa là chưa xác thực, token sai/hết hạn hoặc đăng nhập thất bại. 403 nghĩa là đã xác thực nhưng thiếu quyền. Không có API đăng ký Admin công khai.

Mật khẩu tối thiểu 10 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt. Sai 5 lần sẽ khóa tài khoản trong 5 phút. Đăng ký/đăng nhập giới hạn chung 30 yêu cầu/phút/IP; quá hạn trả 429.

## Tài khoản admin local

Email demo: `admin@genzfashion.test`. Mật khẩu do người dùng tự đặt và lưu ngoài repository; không đoán hoặc tự đặt lại.

Trong Visual Studio: nhấn phải project **GenZFashion.Api → Manage User Secrets**. File mở ra chứa:

- `BootstrapAdmin:Email`: email admin đã khởi tạo.
- `BootstrapAdmin:Password`: mật khẩu đã dùng để tạo admin.
- `Jwt:SigningKey`: khóa ký token.

Không sao chép file secrets, mật khẩu hoặc token vào Git. User Secrets là cấu hình phát triển ngoài repository, không phải kho mã hóa cho production. Thay giá trị BootstrapAdmin:Password sau khi tài khoản đã tồn tại không đổi mật khẩu trong database.

Lệnh khởi tạo một lần (sau khi áp dụng migration):

```powershell
dotnet run --project GenZFashion.Api --launch-profile https -- --bootstrap-admin
```

Lệnh này chỉ chạy Development với đúng SQL Server local/GenZFashionDb, không thay mật khẩu admin đã tồn tại và không nâng quyền tài khoản Customer đã tồn tại. API không tự cập nhật database hoặc khởi tạo tài khoản khi chạy bình thường.

## Tự kiểm tra mà không chép token vào file

Chạy API bằng profile https, rồi mở PowerShell 7 ở thư mục solution:

```powershell
. ./scripts/get-admin-test-headers.ps1
Invoke-RestMethod 'https://localhost:7044/api/admin/products' -Headers $adminHeaders -SkipCertificateCheck
```

Helper đọc User Secrets và giữ token trong bộ nhớ terminal. `-SkipCertificateCheck` chỉ dùng cho kiểm thử chứng chỉ local, không áp dụng cho kết nối production.

Các bài kiểm thử tự động:

```powershell
pwsh -NoProfile -File scripts/test-backend-isolated.ps1
```

Ưu tiên lệnh trên: tạo admin synthetic riêng và chạy toàn bộ auth, commerce, catalog, lookups, sau đó dọn dữ liệu. Không đổi mật khẩu admin thật. Các script riêng bên dưới mặc định đăng nhập admin từ User Secrets; chỉ dùng khi cấu hình đó còn khớp mật khẩu hiện tại:

```powershell
pwsh -NoProfile -File scripts/test-auth.ps1
pwsh -NoProfile -File scripts/test-admin-catalog.ps1
pwsh -NoProfile -File scripts/test-admin-lookups.ps1
```

Các script dùng tài khoản/bản ghi synthetic riêng và dọn chúng sau kiểm thử. Nếu chạy liên tục gặp 429, đợi hết cửa sổ một phút rồi chạy lại.

## Database và triển khai sau này

Migration `AddIdentity` thêm 7 bảng `AspNet*` và hai vai trò Customer/Admin. `AspNetUsers` lưu PasswordHash; không lưu mật khẩu gốc. Dữ liệu catalog hiện có được giữ nguyên.

Khi chuyển máy, cần cấu hình User Secrets riêng trước khi chạy API hoặc EF CLI. Ngoài Development, cung cấp `Jwt__SigningKey` (khóa ngẫu nhiên tối thiểu 32 byte) và `ConnectionStrings__GenZFashionDb` từ môi trường triển khai. Không dùng mật khẩu/khóa demo local cho production.

Bản hiện tại chưa có refresh token, quên/đổi mật khẩu, xác minh email hoặc thu hồi JWT tức thời. Token đã cấp còn hiệu lực tối đa 30 phút; thay đổi vai trò/khóa tài khoản không tự thu hồi token đã cấp. Hết hạn thì đăng nhập lại. Chưa triển khai lên EC2.

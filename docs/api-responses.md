# Mã phản hồi và lỗi API

## OpenAPI và Swagger

Trong Development, Swagger tại `https://localhost:7044/swagger` đọc tài liệu `/openapi/v1.json`. Cả 41 action nghiệp vụ có metadata mã phản hồi rõ ràng qua `ProducesResponseType`; metadata mô tả kết quả, không thay đổi kết quả của controller.

- 200: thành công, trả JSON.
- 201: tạo mới, trả JSON. Các thao tác dùng `CreatedAtAction` còn trả header Location; đăng ký tài khoản hiện không trả Location.
- 204: thành công và không có body, dùng cho các thao tác lưu/xóa/hủy phù hợp. Không gọi đây là lỗi khi Swagger hiện “No Content”.
- 400: dữ liệu hoặc tham số không hợp lệ.
- 401: chưa đăng nhập, token sai/hết hạn hoặc đăng nhập thất bại.
- 403: đã xác thực nhưng thiếu vai trò.
- 404: không tồn tại hoặc không thuộc phạm vi của tài khoản.
- 409: trùng dữ liệu, phiên bản cũ, thiếu tồn kho hoặc chuyển trạng thái không hợp lệ. Đọc thông báo, tải lại dữ liệu và kiểm tra trước khi thử lại.
- 429: vượt giới hạn chung 30 lần đăng ký/đăng nhập trong một phút trên mỗi IP.
- 500: lỗi chưa được xử lý, chỉ trả thông báo chung và traceId.

Mỗi action chỉ khai báo những mã liên quan. Một số JSON thành công và lỗi nghiệp vụ cũ vẫn dùng kiểu anonymous; schema tương ứng còn tổng quát (`object`), chưa mô tả đầy đủ từng trường. Không dùng tài liệu này để sinh client có kiểu dữ liệu đầy đủ ở thời điểm hiện tại. `OrderView`, danh mục/thương hiệu và ProblemDetails đã có schema theo kiểu cụ thể.

## Nội dung lỗi

`UseExceptionHandler` trả lỗi 500 dưới dạng `application/problem+json` trong cả Development và Production, kể cả client yêu cầu HTML. Không gửi exception, stack trace hoặc thông tin kết nối SQL cho client. Exception vẫn do middleware ASP.NET Core ghi log; dùng log phía server để tìm nguyên nhân thay vì trả nội dung lỗi nội bộ ra giao diện. Lỗi xảy ra sau khi response đã bắt đầu hoặc khi client ngắt kết nối không bảo đảm còn đổi được phản hồi.

`UseStatusCodePages` bổ sung ProblemDetails cho lỗi chưa có body dưới `/api`, ví dụ 401/403 từ phân quyền, 404 route không tồn tại và 429. Những phản hồi đã có body được giữ nguyên, bao gồm validation của MVC, lỗi Identity dạng `errors` và lỗi nghiệp vụ dạng `message`. Không sửa mã HTTP hoặc bổ sung body cho 204.

ProblemDetails do middleware mới tạo có `status`, `title`, `detail`, `traceId` và trường `type` do framework cung cấp. Validation thường có thêm `errors` theo tên trường. Các lỗi `message` và lỗi conflict từ filter cũ chưa được chuẩn hóa toàn bộ về một mẫu; frontend hỗ trợ cả hai. Không xem `traceId` là token đăng nhập hoặc nội dung cần gửi vào API.

## Chạy kiểm thử

Sau khi build và chạy API https local:

```powershell
pwsh -NoProfile -File scripts/test-api-contract.ps1
pwsh -NoProfile -File scripts/test-backend-isolated.ps1
```

Script contract chỉ đọc: kiểm tra 41 action, đúng mã 200/201/204, 204 không có body, metadata quyền JWT và lỗi 400/401/404 thực tế. Bộ backend isolated tạo/dọn tài khoản và dữ liệu synthetic, kiểm tra quyền, COD, concurrency và CRUD như trước.

Sau khi build, có thể chạy riêng (không cần API local đang mở):

```powershell
pwsh -NoProfile -File scripts/test-api-failure-isolated.ps1
```

Script này mở đúng một tiến trình API Production tạm trên cổng loopback trống với khóa ngẫu nhiên chỉ ở bộ nhớ và địa chỉ SQL không khả dụng. Nó kiểm tra 500 cho JSON/HTML Accept, không lộ chi tiết nội bộ, ẩn endpoint Development và lỗi 429 khi xen kẽ login/register. Không dùng database hoặc admin thật; luôn dừng tiến trình con trong finally. Đây là kiểm chứng local với cấu hình Production, không phải đã triển khai production lên server.

Trong `GenZFashion.Web`, `npm test` còn kiểm tra frontend đọc ProblemDetails 500, validation, lỗi Identity/`message` cũ và body rỗng 204. Các test frontend dùng response giả lập, không gọi database.

Cơ sở kỹ thuật: [metadata OpenAPI](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/include-metadata?view=aspnetcore-10.0) và [xử lý lỗi API](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/error-handling-api?view=aspnetcore-10.0) của Microsoft.

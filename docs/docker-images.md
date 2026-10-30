# Đóng gói GenZ Fashion bằng Docker

## Phạm vi bước hiện tại

Chuẩn bị hai image độc lập, build trên Ubuntu VMware bằng Jenkins. Chưa chạy website lâu dài, tạo EC2, mở cổng hoặc kết nối database cloud. Không thay đổi pipeline/container Flask.

- `GenZFashion.Api/Dockerfile`: build/publish bằng SDK .NET 10; runtime dùng ASP.NET Core 10, Production, HTTP nội bộ cổng 8080, chạy bằng user app không phải root.
- `GenZFashion.Web/Dockerfile`: build React bằng Node 24, chỉ chép thư mục dist sang image Nginx; không dùng Vite dev server làm web server.
- `GenZFashion.Web/nginx.conf`: phục vụ frontend trên cổng 8080, SPA fallback cho React Router; chuyển `/api` và `/api/...` đến alias `api:8080` trên mạng Docker riêng khi có request. Giữ nguyên đường dẫn và query string. Asset không tồn tại trả 404 thay vì index.html.
- `.dockerignore`: loại build output local, node_modules, cấu hình Development/Local/Production, file env, secrets, chứng chỉ, private key và database/backup khỏi build context. Chỉ dùng appsettings.json không có bí mật trong image.

Dockerfile dùng nhiều stage: SDK/Node phục vụ build; image cuối chỉ chứa runtime và nội dung ứng dụng. Các base image hiện dùng tag theo dòng phiên bản, chưa ghim digest; phiên bản thực tế có thể đổi theo bản vá.

## Cách Jenkins build

Sau các stage test/build đã có, stage `Build application images` chạy lần lượt:

```bash
tag="$(git rev-parse --short=12 HEAD)"
docker build -f GenZFashion.Api/Dockerfile -t "genzfashion-api:$tag" .
docker build -f GenZFashion.Web/Dockerfile -t "genzfashion-web:$tag" .
```

Chạy từ thư mục gốc repository; build context là dấu `.` cuối lệnh. Tên image có tiền tố GenZFashion riêng, tag là 12 ký tự đầu của commit. Image nằm trên Docker host Ubuntu; chưa push registry hoặc chuyển lên EC2. Không chạy lệnh prune/xóa image toàn hệ thống.

Pipeline còn kiểm tra `nginx -t` và nội dung image API bằng container tạm, `--network none`: runtime có DLL, không có appsettings.Development/Local, user khác root. Những container này chỉ kiểm tra đóng gói; không chạy API, không cần JWT hoặc database và tự xóa khi xong. Build/cache image vẫn được Docker giữ lại; cần theo dõi dung lượng khi có nhiều commit.

## Phần cần chốt trước khi chạy website

- Cung cấp `Jwt__SigningKey` và `ConnectionStrings__GenZFashionDb` lúc chạy từ cấu hình ngoài Git/image; không truyền bí mật bằng Docker build arguments.
- Không dùng Windows Authentication/SQL Express trên laptop làm kết nối production Linux. Chưa chọn hoặc tạo tài nguyên database cloud trong bước đóng gói này.
- Khi chạy hai container cùng mạng Docker riêng, API cần alias `api`; frontend gọi URL cùng origin `/api`. Chưa thêm Compose hoặc publish cổng host tại bước này.
- Trước khi đưa website ra Internet, cần cấu hình TLS và proxy tin cậy ở ASP.NET Core. Backend hiện chưa xử lý forwarded headers; giới hạn auth có thể tính chung theo IP của proxy. Không coi việc có nginx.conf là đã hoàn tất HTTPS hoặc chống giả mạo IP.
- Chưa có health/readiness cho Production hoặc quy trình migration/deploy/rollback; API không tự chạy migration.

## Trạng thái kiểm chứng

Trước thay đổi này, log người dùng xác nhận CI và Poll SCM đã chạy thành công tại commit `356f8fb`: 10 test frontend, build frontend, backend build/publish 0 lỗi/0 cảnh báo.

Dockerfile và nginx.conf mới cần được Jenkins build/kiểm tra trên Ubuntu. Máy Windows làm việc hiện không có Docker CLI, nên chưa thể khẳng định hai image mới build hoặc chạy thành công. Bước tiếp theo là đọc log của stage `Build application images` do Poll SCM kích hoạt; chưa coi image build thành công là đã triển khai website.

Tham khảo: [image ASP.NET Core chính thức](https://hub.docker.com/r/microsoft-dotnet-aspnet), [Nginx Dockerfiles](https://github.com/nginx/docker-nginx), [proxy_pass](https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass), [try_files](https://nginx.org/en/docs/http/ngx_http_core_module.html#try_files).

# Chạy thử bằng Docker Compose trên Ubuntu

Compose và Buildx đã được người dùng xác nhận hoạt động bằng tài khoản
`jenkins-agent`: Compose 2.40.3, Buildx 0.30.1. Docker Engine dùng gói Ubuntu
`docker.io`; không chuyển sang Docker CE.

`compose.preview.yaml` dùng hai image đã build trên cùng Docker host. Không
build hoặc pull image khi chạy. Hai service dùng mạng riêng của project
`genzfashion-compose-preview`; Nginx tìm API qua tên service `api`.
Frontend chỉ publish `127.0.0.1:18081`, API không publish cổng host.
Project này độc lập với hai container preview thủ công ở cổng 18080.

## Chạy thử khi chưa có database

Chạy trong shell SSH Ubuntu, từ thư mục gốc repository đã có file Compose.
Image tag bên dưới là bản đã được Jenkins build và smoke test thành công.
Lệnh này dùng database không tồn tại để kiểm tra đường truyền và phản hồi lỗi;
không dùng để kiểm tra danh sách sản phẩm, đăng nhập hoặc đặt hàng.

```bash
export GENZFASHION_IMAGE_TAG=61f093bac19f
export GENZFASHION_JWT_SIGNING_KEY="$(openssl rand -hex 32)"
export GENZFASHION_SQL_CONNECTION='Server=tcp:127.0.0.1,1;Database=GenZFashionDb;Integrated Security=True;Encrypt=True;Connect Timeout=1;ConnectRetryCount=0'

docker compose -f compose.preview.yaml config --quiet
docker compose -f compose.preview.yaml up -d --no-build
docker compose -f compose.preview.yaml ps

unset GENZFASHION_IMAGE_TAG GENZFASHION_JWT_SIGNING_KEY GENZFASHION_SQL_CONNECTION
```

Chỉ chạy `up` nếu bước kiểm tra cấu hình thành công. Không in cấu hình bằng
`docker compose config` mặc định vì kết quả chứa signing key/connection string.
Signing key sinh tạm không được lưu lại; khi tạo lại container sẽ cần cung cấp
lại cấu hình. Đây là preview thủ công, chưa tự khởi động lại sau reboot.

```bash
curl -i --max-time 15 http://127.0.0.1:18081/api/health/live
curl -i --max-time 15 http://127.0.0.1:18081/api/health/ready
curl -i --max-time 15 http://127.0.0.1:18081/api/auth/me
curl -I --max-time 15 http://127.0.0.1:18081/shop
```

Kỳ vọng lần lượt: 200 Healthy, 503 Unhealthy, 401 JSON, 200 HTML.
Readiness 503 là đúng với database giả; chưa phải website đầy đủ chức năng.
Nếu vừa khởi động chưa nhận request được, chờ vài giây rồi thử lại.

Để xem trên Windows, mở một PowerShell riêng và giữ lệnh sau chạy:

```powershell
ssh -N -L 18081:127.0.0.1:18081 ubuntu@192.168.50.128
```

Mở trình duyệt tại `http://127.0.0.1:18081/shop`. Tunnel 18080 cũ có thể giữ
nguyên. Khi có SQL thật, cung cấp connection string bên ngoài Git và thực hiện
migration theo bước riêng; API không tự tạo hoặc cập nhật schema.

Tham khảo: [Compose networking](https://docs.docker.com/compose/how-tos/networking/),
[biến môi trường Compose](https://docs.docker.com/compose/how-tos/environment-variables/variable-interpolation/).

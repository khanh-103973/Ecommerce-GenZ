# Jenkins triển khai preview lên EC2

Chỉ triển khai khi chọn `DEPLOY_EC2_PREVIEW` trong Build with Parameters.
Mặc định false: Poll SCM vẫn chạy CI, không tự triển khai khi đẩy commit.
`EC2_HOST` mặc định là `genzfashion-khanh.duckdns.org`. Sau Stop/Start,
chờ DuckDNS cập nhật IP rồi deploy bằng tên miền này. Vẫn hỗ trợ IPv4 thủ công.
Lần đầu dùng tên miền, cần thêm khóa của tên miền vào known_hosts của user
jenkins-agent sau khi đối chiếu fingerprint với khóa EC2 đã xác nhận.
Không tắt StrictHostKeyChecking. Khi thay instance/khóa SSH phải xác minh lại.

Credential `genzfashion-ec2-ssh` dùng username ubuntu, private key trong Jenkins.
SSH bật StrictHostKeyChecking, không tự tin cậy key lấy từ mạng.
EC2 cần Docker/Compose và quyền sudo không tương tác cho user ubuntu.

File `/home/ubuntu/genzfashion-deploy/.env` do người dùng tạo trên EC2,
mode 600, owner ubuntu, chứa GENZFASHION_JWT_SIGNING_KEY và
GENZFASHION_SQL_CONNECTION. Không lưu bí mật vào Git, không in Compose config;
chỉ dùng config --quiet. Không đưa file .env về agent.

Sau CI thành công, script xuất hai image cùng tag commit, gửi bằng SCP,
kiểm tra SHA256 trên EC2 rồi docker load và compose up. File tar tạm trên agent
được xóa khi thoát; tar trên EC2 được xóa sau khi các kiểm tra thành công.
Nếu lỗi, bản tar trên EC2 còn trong thư mục releases/<tag> để kiểm tra.
Không chạy migration, prune toàn host hoặc thay đổi Jenkins/Flask.

Project `genzfashion-ec2-deploy` dùng cổng loopback 18083 để không thay thế
preview thủ công ở 18081. Trên t3.micro, hai bản chạy song song chỉ phục vụ
chuyển tiếp; sau khi bản deploy được xác nhận cần dừng preview thủ công để
tiết kiệm RAM. Compose dùng restart: unless-stopped cho API/Web để tự chạy lại khi Docker/EC2 khởi động. Docker service cần được enable; container bị docker stop thủ công cần được start lại.

Kiểm tra sau deploy: live 200 Healthy, shop 200, auth/me 401, ready 200 Healthy.
EC2 dùng database GearHost genzfashion2026 trên den1.mssql7.gear.host. Readiness được thử tối đa 6 lần, mỗi lần tối đa 35 giây. CI smoke test cô lập vẫn dùng SQL giả và yêu cầu 503.
Đã áp dụng 4 migration và kiểm tra thủ công catalog, đăng nhập, COD/hủy và hoàn tồn ngày 31/10/2026. Cần hoàn thiện kiểm tra
nghiệp vụ, HTTPS/proxy trước khi công khai. Chưa có tự rollback: nếu up hoặc
kiểm tra thất bại, build báo lỗi, service có thể đã thay đổi. Tag deploy đạt
được ghi ở deployed-preview-tag; giữ các image cũ để phục vụ xử lý thủ công.

Windows xem bản này bằng tunnel (thay IP nếu đổi):

```powershell
ssh -i "D:\Download\EC2-Student-Key.pem" -N -L 18084:127.0.0.1:18083 ubuntu@16.178.147.10
```

Mở http://127.0.0.1:18084/shop.

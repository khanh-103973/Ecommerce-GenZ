# Health check và kiểm thử container

Hai endpoint có trong Development và Production, không cần đăng nhập, trả text thuần và không đưa lỗi SQL hoặc chuỗi kết nối vào response:

- `GET /api/health/live`: HTTP 200, `Healthy`, nếu tiến trình HTTP đang phục vụ được yêu cầu. Không kiểm tra SQL.
- `GET /api/health/ready`: HTTP 200, `Healthy`, khi EF Core kết nối được database cấu hình; HTTP 503, `Unhealthy`, nếu không kết nối được. Có cancellation sau 5 giây cho lần kiểm tra kết nối.

Readiness chỉ xác nhận kết nối, không chứng minh migration, schema, dữ liệu hoặc toàn bộ nghiệp vụ đã đúng. Không chạy migration, seed hoặc tạo database trong health check. Đường `/health/database` cũ vẫn chỉ có trong Development.

Khi có database cloud serverless, cần chọn tần suất readiness phù hợp: kiểm tra kết nối có thể đánh thức database. Không dùng readiness như endpoint liveness để tự khởi động lại API mỗi khi SQL tạm thời lỗi. Trước public deployment cần chốt TLS, proxy tin cậy và phạm vi truy cập health endpoint.

## Kiểm chứng local

Đã build backend 0 lỗi/0 cảnh báo. Trên API local kết nối SQL Express, cả live và ready trả 200 Healthy. Bài `scripts/test-api-failure-isolated.ps1` đạt live=200 và ready=503 trên API Production tạm dùng khóa ngẫu nhiên và kết nối SQL cố ý không khả dụng; kiểm tra lỗi 500/429 và ẩn endpoint Development tiếp tục đạt. `scripts/test-api-contract.ps1` cho 41 action nghiệp vụ vẫn đạt. Các health check không thay đổi hợp đồng của controller hiện có.

## Kiểm thử Docker qua Jenkins

Sau stage build hai image, `Docker smoke test` chạy `bash scripts/test-docker-smoke.sh` từ gốc repository. Script dùng tag commit hiện tại, tạo tên network/container riêng theo build và PID, mở mạng Docker nội bộ với alias `api`/`web`, không publish cổng host. Khóa JWT chỉ được tạo trong bộ nhớ, không in hoặc lưu Git; SQL trỏ đến loopback cổng 1 trong container, không dùng database thật.

Container Node tạm chạy `scripts/docker-smoke-client.mjs`, kiểm tra:

1. API liveness trực tiếp và qua Nginx trả 200 Healthy.
2. Readiness trực tiếp và qua Nginx trả 503 Unhealthy vì cố ý không có database.
3. Route React `/shop` trả trang có root và JavaScript build tải được.
4. Asset không tồn tại trả 404.
5. `/api/auth/me` qua Nginx trả 401 ProblemDetails, route API không tồn tại có query string trả 404 JSON.

503 trong bài này là kết quả mong đợi để kiểm tra phân biệt live/ready, không phải điều kiện chấp nhận deployment thật. Deployment có database thật phải kiểm tra ready=200 trước khi coi là sẵn sàng.

Khi kết thúc, trap dọn đúng container API/Web và network do lượt kiểm thử tạo; container kiểm tra Node dùng `--rm`. Không thay đổi các container `genzfashion-*-preview`, Jenkins hoặc Flask. Không dùng prune/xóa tài nguyên toàn hệ thống.

Máy Windows không có Docker CLI: cú pháp Bash/JavaScript đã kiểm tra, nhưng kết quả kiểm thử Docker mới vẫn chờ log Jenkins trên Ubuntu. Không coi các kết quả local là bằng chứng container đã đạt.

Tham khảo: [health checks của ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/health-checks?view=aspnetcore-10.0).

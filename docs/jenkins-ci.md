# Jenkins CI — GenZ Fashion

## Cấu hình đã kiểm chứng

- Repository: `https://github.com/khanh-103973/Ecommerce-GenZ.git`, nhánh `main`.
- Job riêng: `ecommerce-cicd`, loại Pipeline script from SCM, Script Path `Jenkinsfile`.
- Agent: `ubuntu-docker-agent`, label `ubuntu-docker`, tài khoản `jenkins-agent` có quyền dùng Docker.
- Frontend chạy trong `node:24-bookworm-slim`: npm ci, 10 bài test, kiểm tra định dạng và build.
- Backend chạy trong `mcr.microsoft.com/dotnet/sdk:10.0`: restore, build Release và publish tạm trong container.
- Log do người dùng cung cấp xác nhận pipeline từ Jenkinsfile tại commit `7b08c04` kết thúc SUCCESS; backend build 0 lỗi/0 cảnh báo.

## Kiểm chứng Poll SCM

Ngày 30/10/2026, người dùng đã lưu Poll SCM với lịch `H/2 * * * *` cho job `ecommerce-cicd`. Build periodically không được chọn.

Đã kiểm chứng bằng log người dùng gửi: `Started by an SCM change`, checkout commit `356f8fb5337f72294727423c1fc42eced6f2fef2`, frontend 10/10 test và build, backend build/publish 0 lỗi/0 cảnh báo, kết thúc `Finished: SUCCESS`.

Sau khi push commit chứa tài liệu này:

1. Giữ Ubuntu VMware, Docker, Jenkins và agent hoạt động.
2. Không bấm Build Now. Chờ lượt polling kế tiếp, thường khoảng 2 phút và có thể lâu hơn khi Jenkins bận.
3. Mở build mới của `ecommerce-cicd`, xem Console Output.
4. Xác nhận nguyên nhân bắt đầu là thay đổi SCM, thường hiển thị `Started by an SCM change`; commit checkout phải khớp commit mới trên GitHub.
5. Chỉ kết luận kiểm chứng đạt khi build tự kích hoạt kết thúc SUCCESS.

Nếu chưa có build mới, xem Git Polling Log của job để kiểm tra lượt polling, kết nối repository và nhánh được theo dõi.

## Giới hạn hiện tại

Đã nhận log xác nhận build image API/Web tại commit `7fdd5b9` kết thúc SUCCESS, Nginx syntax hợp lệ và kiểm tra user/config runtime API đạt. Sau đó đã thêm stage `Docker smoke test` và health live/ready; stage mới còn chờ kiểm chứng Jenkins. Xem [health checks](health-checks.md).

Pipeline kiểm thử frontend và biên dịch/publish backend. Đã bổ sung stage build image ứng dụng và kiểm tra đóng gói; stage mới còn chờ kết quả chạy Jenkins. Xem [đóng gói Docker](docker-images.md). Chưa chạy kiểm thử nghiệp vụ backend với SQL Server trên Jenkins hoặc deploy AWS. Bản publish backend ở stage build/publish vẫn nằm trong thư mục tạm và mất khi container kết thúc.

Không dùng secrets/database Windows local trong pipeline. Không thay đổi job `demo-cicd`, ứng dụng Flask hoặc tài nguyên AWS. Các tag image hiện có thể thay đổi theo bản vá; log ghi phiên bản thực tế của Node/npm/.NET ở từng lần chạy.

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

Tệp này được thêm để tạo một thay đổi Git phục vụ kiểm chứng tự kích hoạt. Tại thời điểm ghi tài liệu, kết quả tự kích hoạt còn chờ xác nhận, không coi việc lưu lịch là bằng chứng Jenkins đã tự chạy.

Sau khi push commit chứa tài liệu này:

1. Giữ Ubuntu VMware, Docker, Jenkins và agent hoạt động.
2. Không bấm Build Now. Chờ lượt polling kế tiếp, thường khoảng 2 phút và có thể lâu hơn khi Jenkins bận.
3. Mở build mới của `ecommerce-cicd`, xem Console Output.
4. Xác nhận nguyên nhân bắt đầu là thay đổi SCM, thường hiển thị `Started by an SCM change`; commit checkout phải khớp commit mới trên GitHub.
5. Chỉ kết luận kiểm chứng đạt khi build tự kích hoạt kết thúc SUCCESS.

Nếu chưa có build mới, xem Git Polling Log của job để kiểm tra lượt polling, kết nối repository và nhánh được theo dõi.

## Giới hạn hiện tại

Pipeline hiện kiểm thử frontend và biên dịch/publish backend. Chưa chạy kiểm thử nghiệp vụ backend với SQL Server trên Jenkins; chưa đóng gói image ứng dụng hoặc deploy AWS. Bản publish backend nằm trong thư mục tạm và mất khi container kết thúc.

Không dùng secrets/database Windows local trong pipeline. Không thay đổi job `demo-cicd`, ứng dụng Flask hoặc tài nguyên AWS. Các tag image hiện có thể thay đổi theo bản vá; log ghi phiên bản thực tế của Node/npm/.NET ở từng lần chạy.

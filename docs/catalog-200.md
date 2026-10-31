# Catalog demo 200 sản phẩm

Ảnh gốc từ https://github.com/lightly-ai/dataset_clothing_images, bản sao tập validation của https://github.com/alexeygrigorev/clothing-dataset-small. Hai nguồn công bố giấy phép CC0-1.0. Nguồn và SHA-256 từng ảnh nằm trong `GenZFashion.Web/public/catalog-200/catalog.json`.

Tên mô tả nhóm quần áo; không xác nhận nhãn hiệu, chất liệu hoặc thông số hàng thật. Giá và tồn kho là dữ liệu giả lập. CC0 không bảo đảm quyền nhãn hiệu hoặc hình ảnh cá nhân; bộ này dùng minh họa dự án.

Deploy ảnh cùng frontend trước, sau đó chạy `scripts/import-catalog-200.sql` trong SSMS trên database genzfashion2026. Script thêm 200 sản phẩm và có thể chạy lại mà không thêm trùng SKU. Không xóa sản phẩm cũ, tài khoản hoặc đơn hàng, vì vậy tổng dự kiến là 220 sản phẩm nếu đang có 20 sản phẩm cũ.

Trước khi nhập, kiểm tra dung lượng còn lại của gói GearHost 10 MB và lưu bản sao dữ liệu hiện tại. Ảnh nằm trên web EC2, database chỉ chứa đường dẫn. Chưa chạy script lên database trong bước chuẩn bị này.

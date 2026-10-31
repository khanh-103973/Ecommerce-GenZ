-- Additive demo import: preserves existing products, users and orders.
USE [genzfashion2026];
SET XACT_ABORT ON;
BEGIN TRANSACTION;
DECLARE @brand int, @category int, @product int;
IF NOT EXISTS (SELECT 1 FROM dbo.Brands WHERE Name=N'CC0 Demo') INSERT dbo.Brands(Name) VALUES(N'CC0 Demo');
SELECT @brand=Id FROM dbo.Brands WHERE Name=N'CC0 Demo';
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-001') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-001',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-001.jpg',N'Đầm mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-002') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-002',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-002.jpg',N'Đầm mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-003') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-003',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-003.jpg',N'Đầm mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-004') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-004',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-004.jpg',N'Đầm mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-005') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-005',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-005.jpg',N'Đầm mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-006') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-006',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-006.jpg',N'Đầm mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-007') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-007',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-007.jpg',N'Đầm mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-008') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-008',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-008.jpg',N'Đầm mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-009') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-009',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-009.jpg',N'Đầm mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-010') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-010',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-010.jpg',N'Đầm mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-011') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-011',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-011.jpg',N'Đầm mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-012') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-012',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-012.jpg',N'Đầm mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-013') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-013',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-013.jpg',N'Đầm mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-014') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-014',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-014.jpg',N'Đầm mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-015') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-015',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-015.jpg',N'Đầm mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-016') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-016',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-016.jpg',N'Đầm mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-017') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-017',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-017.jpg',N'Đầm mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-018') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-018',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-018.jpg',N'Đầm mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-019') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-019',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-019.jpg',N'Đầm mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-020') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Đầm') INSERT dbo.Categories(Name) VALUES(N'Đầm');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Đầm';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Đầm mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-020',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-020.jpg',N'Đầm mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-021') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Mũ') INSERT dbo.Categories(Name) VALUES(N'Mũ');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Mũ';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Mũ mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-021',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-021.jpg',N'Mũ mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-022') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Mũ') INSERT dbo.Categories(Name) VALUES(N'Mũ');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Mũ';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Mũ mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-022',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-022.jpg',N'Mũ mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-023') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Mũ') INSERT dbo.Categories(Name) VALUES(N'Mũ');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Mũ';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Mũ mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-023',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-023.jpg',N'Mũ mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-024') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Mũ') INSERT dbo.Categories(Name) VALUES(N'Mũ');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Mũ';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Mũ mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-024',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-024.jpg',N'Mũ mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-025') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Mũ') INSERT dbo.Categories(Name) VALUES(N'Mũ');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Mũ';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Mũ mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-025',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-025.jpg',N'Mũ mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-026') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-026',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-026.jpg',N'Áo dài tay mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-027') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-027',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-027.jpg',N'Áo dài tay mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-028') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-028',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-028.jpg',N'Áo dài tay mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-029') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-029',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-029.jpg',N'Áo dài tay mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-030') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-030',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-030.jpg',N'Áo dài tay mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-031') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-031',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-031.jpg',N'Áo dài tay mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-032') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-032',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-032.jpg',N'Áo dài tay mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-033') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-033',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-033.jpg',N'Áo dài tay mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-034') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-034',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-034.jpg',N'Áo dài tay mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-035') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-035',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-035.jpg',N'Áo dài tay mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-036') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-036',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-036.jpg',N'Áo dài tay mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-037') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-037',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-037.jpg',N'Áo dài tay mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-038') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-038',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-038.jpg',N'Áo dài tay mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-039') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-039',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-039.jpg',N'Áo dài tay mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-040') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-040',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-040.jpg',N'Áo dài tay mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-041') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-041',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-041.jpg',N'Áo dài tay mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-042') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-042',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-042.jpg',N'Áo dài tay mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-043') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-043',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-043.jpg',N'Áo dài tay mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-044') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-044',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-044.jpg',N'Áo dài tay mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-045') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-045',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-045.jpg',N'Áo dài tay mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-046') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 21',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-046',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-046.jpg',N'Áo dài tay mẫu 21',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-047') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 22',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-047',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-047.jpg',N'Áo dài tay mẫu 22',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-048') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 23',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-048',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-048.jpg',N'Áo dài tay mẫu 23',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-049') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 24',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-049',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-049.jpg',N'Áo dài tay mẫu 24',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-050') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 25',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-050',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-050.jpg',N'Áo dài tay mẫu 25',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-051') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 26',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-051',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-051.jpg',N'Áo dài tay mẫu 26',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-052') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 27',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-052',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-052.jpg',N'Áo dài tay mẫu 27',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-053') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 28',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-053',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-053.jpg',N'Áo dài tay mẫu 28',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-054') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 29',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-054',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-054.jpg',N'Áo dài tay mẫu 29',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-055') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo dài tay') INSERT dbo.Categories(Name) VALUES(N'Áo dài tay');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo dài tay';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo dài tay mẫu 30',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-055',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-055.jpg',N'Áo dài tay mẫu 30',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-056') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-056',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-056.jpg',N'Áo khoác mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-057') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-057',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-057.jpg',N'Áo khoác mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-058') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-058',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-058.jpg',N'Áo khoác mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-059') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-059',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-059.jpg',N'Áo khoác mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-060') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-060',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-060.jpg',N'Áo khoác mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-061') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-061',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-061.jpg',N'Áo khoác mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-062') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-062',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-062.jpg',N'Áo khoác mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-063') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-063',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-063.jpg',N'Áo khoác mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-064') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-064',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-064.jpg',N'Áo khoác mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-065') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-065',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-065.jpg',N'Áo khoác mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-066') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-066',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-066.jpg',N'Áo khoác mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-067') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-067',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-067.jpg',N'Áo khoác mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-068') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-068',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-068.jpg',N'Áo khoác mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-069') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-069',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-069.jpg',N'Áo khoác mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-070') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo khoác') INSERT dbo.Categories(Name) VALUES(N'Áo khoác');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo khoác';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo khoác mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-070',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-070.jpg',N'Áo khoác mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-071') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-071',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-071.jpg',N'Quần dài mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-072') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-072',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-072.jpg',N'Quần dài mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-073') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-073',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-073.jpg',N'Quần dài mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-074') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-074',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-074.jpg',N'Quần dài mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-075') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-075',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-075.jpg',N'Quần dài mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-076') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-076',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-076.jpg',N'Quần dài mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-077') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-077',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-077.jpg',N'Quần dài mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-078') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-078',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-078.jpg',N'Quần dài mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-079') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-079',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-079.jpg',N'Quần dài mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-080') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-080',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-080.jpg',N'Quần dài mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-081') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-081',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-081.jpg',N'Quần dài mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-082') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-082',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-082.jpg',N'Quần dài mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-083') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-083',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-083.jpg',N'Quần dài mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-084') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-084',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-084.jpg',N'Quần dài mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-085') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-085',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-085.jpg',N'Quần dài mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-086') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-086',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-086.jpg',N'Quần dài mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-087') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-087',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-087.jpg',N'Quần dài mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-088') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-088',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-088.jpg',N'Quần dài mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-089') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-089',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-089.jpg',N'Quần dài mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-090') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-090',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-090.jpg',N'Quần dài mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-091') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 21',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-091',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-091.jpg',N'Quần dài mẫu 21',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-092') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 22',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-092',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-092.jpg',N'Quần dài mẫu 22',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-093') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 23',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-093',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-093.jpg',N'Quần dài mẫu 23',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-094') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 24',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-094',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-094.jpg',N'Quần dài mẫu 24',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-095') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 25',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-095',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-095.jpg',N'Quần dài mẫu 25',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-096') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 26',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-096',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-096.jpg',N'Quần dài mẫu 26',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-097') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 27',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-097',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-097.jpg',N'Quần dài mẫu 27',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-098') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 28',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-098',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-098.jpg',N'Quần dài mẫu 28',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-099') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 29',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-099',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-099.jpg',N'Quần dài mẫu 29',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-100') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần dài') INSERT dbo.Categories(Name) VALUES(N'Quần dài');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần dài';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần dài mẫu 30',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-100',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-100.jpg',N'Quần dài mẫu 30',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-101') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-101',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-101.jpg',N'Áo sơ mi mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-102') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-102',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-102.jpg',N'Áo sơ mi mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-103') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-103',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-103.jpg',N'Áo sơ mi mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-104') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-104',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-104.jpg',N'Áo sơ mi mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-105') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-105',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-105.jpg',N'Áo sơ mi mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-106') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-106',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-106.jpg',N'Áo sơ mi mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-107') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-107',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-107.jpg',N'Áo sơ mi mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-108') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-108',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-108.jpg',N'Áo sơ mi mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-109') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-109',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-109.jpg',N'Áo sơ mi mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-110') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-110',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-110.jpg',N'Áo sơ mi mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-111') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-111',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-111.jpg',N'Áo sơ mi mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-112') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-112',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-112.jpg',N'Áo sơ mi mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-113') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-113',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-113.jpg',N'Áo sơ mi mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-114') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-114',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-114.jpg',N'Áo sơ mi mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-115') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-115',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-115.jpg',N'Áo sơ mi mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-116') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-116',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-116.jpg',N'Áo sơ mi mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-117') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-117',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-117.jpg',N'Áo sơ mi mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-118') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-118',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-118.jpg',N'Áo sơ mi mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-119') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-119',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-119.jpg',N'Áo sơ mi mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-120') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-120',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-120.jpg',N'Áo sơ mi mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-121') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 21',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-121',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-121.jpg',N'Áo sơ mi mẫu 21',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-122') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 22',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-122',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-122.jpg',N'Áo sơ mi mẫu 22',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-123') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 23',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-123',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-123.jpg',N'Áo sơ mi mẫu 23',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-124') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 24',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-124',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-124.jpg',N'Áo sơ mi mẫu 24',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-125') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo sơ mi') INSERT dbo.Categories(Name) VALUES(N'Áo sơ mi');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo sơ mi';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo sơ mi mẫu 25',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-125',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-125.jpg',N'Áo sơ mi mẫu 25',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-126') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-126',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-126.jpg',N'Giày dép mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-127') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-127',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-127.jpg',N'Giày dép mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-128') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-128',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-128.jpg',N'Giày dép mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-129') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-129',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-129.jpg',N'Giày dép mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-130') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-130',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-130.jpg',N'Giày dép mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-131') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-131',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-131.jpg',N'Giày dép mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-132') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-132',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-132.jpg',N'Giày dép mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-133') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-133',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-133.jpg',N'Giày dép mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-134') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-134',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-134.jpg',N'Giày dép mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-135') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-135',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-135.jpg',N'Giày dép mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-136') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-136',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-136.jpg',N'Giày dép mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-137') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-137',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-137.jpg',N'Giày dép mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-138') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-138',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-138.jpg',N'Giày dép mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-139') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-139',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-139.jpg',N'Giày dép mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-140') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Giày dép') INSERT dbo.Categories(Name) VALUES(N'Giày dép');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Giày dép';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Giày dép mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-140',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-140.jpg',N'Giày dép mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-141') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-141',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-141.jpg',N'Quần short mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-142') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-142',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-142.jpg',N'Quần short mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-143') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-143',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-143.jpg',N'Quần short mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-144') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-144',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-144.jpg',N'Quần short mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-145') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-145',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-145.jpg',N'Quần short mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-146') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-146',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-146.jpg',N'Quần short mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-147') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-147',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-147.jpg',N'Quần short mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-148') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-148',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-148.jpg',N'Quần short mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-149') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-149',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-149.jpg',N'Quần short mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-150') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-150',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-150.jpg',N'Quần short mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-151') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-151',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-151.jpg',N'Quần short mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-152') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-152',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-152.jpg',N'Quần short mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-153') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-153',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-153.jpg',N'Quần short mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-154') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-154',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-154.jpg',N'Quần short mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-155') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-155',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-155.jpg',N'Quần short mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-156') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-156',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-156.jpg',N'Quần short mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-157') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-157',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-157.jpg',N'Quần short mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-158') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-158',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-158.jpg',N'Quần short mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-159') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-159',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-159.jpg',N'Quần short mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-160') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Quần short') INSERT dbo.Categories(Name) VALUES(N'Quần short');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Quần short';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Quần short mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-160',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-160.jpg',N'Quần short mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-161') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-161',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-161.jpg',N'Chân váy mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-162') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-162',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-162.jpg',N'Chân váy mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-163') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-163',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-163.jpg',N'Chân váy mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-164') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-164',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-164.jpg',N'Chân váy mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-165') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-165',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-165.jpg',N'Chân váy mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-166') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-166',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-166.jpg',N'Chân váy mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-167') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-167',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-167.jpg',N'Chân váy mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-168') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-168',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-168.jpg',N'Chân váy mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-169') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-169',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-169.jpg',N'Chân váy mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-170') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Chân váy') INSERT dbo.Categories(Name) VALUES(N'Chân váy');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Chân váy';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Chân váy mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-170',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-170.jpg',N'Chân váy mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-171') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 01',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-171',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-171.jpg',N'Áo thun mẫu 01',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-172') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 02',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-172',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-172.jpg',N'Áo thun mẫu 02',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-173') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 03',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-173',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-173.jpg',N'Áo thun mẫu 03',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-174') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 04',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-174',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-174.jpg',N'Áo thun mẫu 04',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-175') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 05',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-175',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-175.jpg',N'Áo thun mẫu 05',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-176') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 06',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-176',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-176.jpg',N'Áo thun mẫu 06',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-177') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 07',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-177',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-177.jpg',N'Áo thun mẫu 07',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-178') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 08',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-178',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-178.jpg',N'Áo thun mẫu 08',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-179') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 09',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-179',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-179.jpg',N'Áo thun mẫu 09',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-180') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 10',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-180',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-180.jpg',N'Áo thun mẫu 10',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-181') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 11',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-181',N'Demo',N'Theo ảnh',160000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-181.jpg',N'Áo thun mẫu 11',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-182') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 12',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-182',N'Demo',N'Theo ảnh',170000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-182.jpg',N'Áo thun mẫu 12',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-183') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 13',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-183',N'Demo',N'Theo ảnh',180000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-183.jpg',N'Áo thun mẫu 13',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-184') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 14',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-184',N'Demo',N'Theo ảnh',190000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-184.jpg',N'Áo thun mẫu 14',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-185') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 15',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-185',N'Demo',N'Theo ảnh',200000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-185.jpg',N'Áo thun mẫu 15',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-186') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 16',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-186',N'Demo',N'Theo ảnh',210000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-186.jpg',N'Áo thun mẫu 16',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-187') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 17',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-187',N'Demo',N'Theo ảnh',220000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-187.jpg',N'Áo thun mẫu 17',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-188') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 18',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-188',N'Demo',N'Theo ảnh',230000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-188.jpg',N'Áo thun mẫu 18',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-189') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 19',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-189',N'Demo',N'Theo ảnh',240000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-189.jpg',N'Áo thun mẫu 19',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-190') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 20',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-190',N'Demo',N'Theo ảnh',250000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-190.jpg',N'Áo thun mẫu 20',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-191') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 21',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-191',N'Demo',N'Theo ảnh',260000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-191.jpg',N'Áo thun mẫu 21',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-192') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 22',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-192',N'Demo',N'Theo ảnh',270000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-192.jpg',N'Áo thun mẫu 22',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-193') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 23',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-193',N'Demo',N'Theo ảnh',280000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-193.jpg',N'Áo thun mẫu 23',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-194') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 24',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-194',N'Demo',N'Theo ảnh',290000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-194.jpg',N'Áo thun mẫu 24',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-195') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 25',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-195',N'Demo',N'Theo ảnh',300000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-195.jpg',N'Áo thun mẫu 25',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-196') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 26',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-196',N'Demo',N'Theo ảnh',310000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-196.jpg',N'Áo thun mẫu 26',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-197') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 27',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-197',N'Demo',N'Theo ảnh',320000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-197.jpg',N'Áo thun mẫu 27',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-198') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 28',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-198',N'Demo',N'Theo ảnh',330000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-198.jpg',N'Áo thun mẫu 28',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-199') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 29',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-199',N'Demo',N'Theo ảnh',340000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-199.jpg',N'Áo thun mẫu 29',0);
END;
IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku=N'CC0-200') BEGIN
IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name=N'Áo thun') INSERT dbo.Categories(Name) VALUES(N'Áo thun');
SELECT @category=Id FROM dbo.Categories WHERE Name=N'Áo thun';
INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES(N'Áo thun mẫu 30',N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);
SET @product=CONVERT(int,SCOPE_IDENTITY());
INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,N'CC0-200',N'Demo',N'Theo ảnh',150000,25,1);
INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,N'https://genzfashion-khanh.duckdns.org/catalog-200/gz-200.jpg',N'Áo thun mẫu 30',0);
END;
COMMIT;
SELECT COUNT(*) AS ImportedProducts FROM dbo.ProductVariants WHERE Sku LIKE N'CC0-%';
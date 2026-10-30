-- Synthetic demo data only. Run explicitly; never on application startup.
SET XACT_ABORT ON;
IF CONVERT(nvarchar(128), SERVERPROPERTY('ServerName')) <> N'KHANHS\SQLEXPRESS'
    THROW 50000, 'Unexpected server.', 1;
IF DB_NAME() <> N'GenZFashionDb'
    THROW 50001, 'Unexpected database.', 1;
BEGIN TRANSACTION;
-- Only seed an empty catalog; subsequent runs safely do nothing.
IF EXISTS (SELECT 1 FROM dbo.Products) OR EXISTS (SELECT 1 FROM dbo.Categories)
   OR EXISTS (SELECT 1 FROM dbo.Brands) OR EXISTS (SELECT 1 FROM dbo.ProductVariants)
BEGIN
    ROLLBACK;
    PRINT 'Catalog is not empty. No data changed.';
    RETURN;
END;
INSERT dbo.Categories(Name) VALUES (N'Áo thun [synthetic]'), (N'Hoodie [synthetic]'), (N'Quần [synthetic]'), (N'Áo khoác [synthetic]');
INSERT dbo.Brands(Name) VALUES (N'GenZ Demo [synthetic]');
DECLARE @brand int = (SELECT Id FROM dbo.Brands WHERE Name = N'GenZ Demo [synthetic]');
DECLARE @i int = 1;
WHILE @i <= 20
BEGIN
    DECLARE @category int, @name nvarchar(100);
    SELECT @category = Id, @name = Name FROM dbo.Categories ORDER BY Id OFFSET ((@i - 1) % 4) ROWS FETCH NEXT 1 ROWS ONLY;
    INSERT dbo.Products(Name, Description, CategoryId, BrandId, IsActive)
    VALUES (@name + N' mẫu ' + CONVERT(nvarchar(10), @i), N'synthetic: Dữ liệu giả lập phục vụ học tập và kiểm thử.', @category, @brand, 1);
    DECLARE @product int = CONVERT(int, SCOPE_IDENTITY());
    INSERT dbo.ProductVariants(ProductId, Sku, Size, Color, Price, StockQuantity, IsActive)
    SELECT @product, CONCAT('SYN-', @i, '-', s.Size, '-', c.Code), s.Size, c.Color,
        150000 + @i * 10000, CASE WHEN @i = 20 THEN 0 ELSE @i + 5 END, 1
    FROM (VALUES ('M'), ('L')) s(Size)
    CROSS JOIN (VALUES ('BLK', N'Đen'), ('WHT', N'Trắng')) c(Code, Color);
    SET @i += 1;
END;
COMMIT;

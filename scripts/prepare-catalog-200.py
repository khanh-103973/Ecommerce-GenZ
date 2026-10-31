"""Prepare 200 distinct CC0 photos and an additive SQL import. No database connection."""
import hashlib
import json
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'GenZFashion.Web/public/catalog-200'
DEST.mkdir(parents=True, exist_ok=True)
groups = {
    'dress': ('Đầm', 20), 'hat': ('Mũ', 5),
    'longsleeve': ('Áo dài tay', 30), 'outwear': ('Áo khoác', 15),
    'pants': ('Quần dài', 30), 'shirt': ('Áo sơ mi', 25),
    'shoes': ('Giày dép', 15), 'shorts': ('Quần short', 20),
    'skirt': ('Chân váy', 10), 't-shirt': ('Áo thun', 30),
}
tree = json.loads((ROOT / 'scripts/clothing-source-tree.json').read_text())
products, hashes = [], set()
for folder, (category, count) in groups.items():
    selected = 0
    for photo in sorted((ROOT / '.catalog-work' / folder).glob('*.jpg')):
        digest = hashlib.sha256(photo.read_bytes()).hexdigest()
        if digest in hashes:
            continue
        hashes.add(digest)
        number = len(products) + 1
        filename = f'gz-{number:03}.jpg'
        shutil.copyfile(photo, DEST / filename)
        products.append(dict(code=f'CC0-{number:03}', name=f'{category} mẫu {selected+1:02}',
            category=category, price=150000 + (number % 20)*10000,
            imageUrl=f'https://genzfashion-khanh.duckdns.org/catalog-200/{filename}',
            sha256=digest, source=f'https://github.com/lightly-ai/dataset_clothing_images/blob/{tree["sha"]}/{photo.relative_to(ROOT / ".catalog-work").as_posix()}',
            license='CC0-1.0'))
        selected += 1
        if selected == count:
            break
    assert selected == count
assert len(products) == len(hashes) == 200
(DEST / 'catalog.json').write_text(json.dumps(products, ensure_ascii=False, indent=2), encoding='utf-8')
def sql(value):
    return "N'" + value.replace("'", "''") + "'"
lines = ["-- Additive demo import: preserves existing products, users and orders.",
    "USE [genzfashion2026];", "SET XACT_ABORT ON;", "BEGIN TRANSACTION;",
    "DECLARE @brand int, @category int, @product int;",
    "IF NOT EXISTS (SELECT 1 FROM dbo.Brands WHERE Name=N'CC0 Demo') INSERT dbo.Brands(Name) VALUES(N'CC0 Demo');",
    "SELECT @brand=Id FROM dbo.Brands WHERE Name=N'CC0 Demo';"]
for p in products:
    lines += [f"IF NOT EXISTS (SELECT 1 FROM dbo.ProductVariants WHERE Sku={sql(p['code'])}) BEGIN",
        f"IF NOT EXISTS (SELECT 1 FROM dbo.Categories WHERE Name={sql(p['category'])}) INSERT dbo.Categories(Name) VALUES({sql(p['category'])});",
        f"SELECT @category=Id FROM dbo.Categories WHERE Name={sql(p['category'])};",
        f"INSERT dbo.Products(Name,Description,CategoryId,BrandId,IsActive) VALUES({sql(p['name'])},N'Sản phẩm minh họa. Giá và tồn kho giả lập; ảnh CC0 từ Clothing Dataset. Không phải thông tin hàng hóa thực tế.',@category,@brand,1);",
        "SET @product=CONVERT(int,SCOPE_IDENTITY());",
        f"INSERT dbo.ProductVariants(ProductId,Sku,Size,Color,Price,StockQuantity,IsActive) VALUES(@product,{sql(p['code'])},N'Demo',N'Theo ảnh',{p['price']},25,1);",
        f"INSERT dbo.ProductImages(ProductId,Url,AltText,SortOrder) VALUES(@product,{sql(p['imageUrl'])},{sql(p['name'])},0);", "END;"]
lines += ["COMMIT;", "SELECT COUNT(*) AS ImportedProducts FROM dbo.ProductVariants WHERE Sku LIKE N'CC0-%';"]
(ROOT / 'scripts/import-catalog-200.sql').write_text('\n'.join(lines), encoding='utf-8-sig')
print(f'Prepared {len(products)} unique originals, {sum(p.stat().st_size for p in DEST.glob("*.jpg"))/1048576:.1f} MB')

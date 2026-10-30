using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Authorization;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

// Administrative operations require a valid JWT with the Admin role.
[ApiController]
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Authorize(Roles = "Admin")]
[ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
[ProducesResponseType(typeof(ProblemDetails), 403, "application/problem+json", Description = "Tài khoản không có vai trò được yêu cầu.")]
[Route("api/admin/products")]
public class AdminProductsController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    public async Task<IActionResult> List(
        [FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10,
        CancellationToken cancellationToken = default)
    {
        var total = await db.Products.CountAsync(cancellationToken);
        var items = await db.Products.AsNoTracking().OrderBy(p => p.Id)
            .Skip((page - 1) * pageSize).Take(pageSize)
            .Select(p => new { p.Id, p.Name, p.CategoryId, p.BrandId, p.IsActive })
            .ToListAsync(cancellationToken);
        return Ok(new { items, total, page, pageSize });
    }

    [HttpGet("lookups")]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    public async Task<IActionResult> Lookups(CancellationToken cancellationToken)
    {
        var categories = await db.Categories.AsNoTracking().OrderBy(x => x.Name).ToListAsync(cancellationToken);
        var brands = await db.Brands.AsNoTracking().OrderBy(x => x.Name).ToListAsync(cancellationToken);
        return Ok(new { categories, brands });
    }

    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    public async Task<IActionResult> Detail(int id, CancellationToken cancellationToken)
    {
        var product = await db.Products.AsNoTracking().Where(p => p.Id == id)
            .Select(p => new
            {
                p.Id, p.Name, p.Description, p.CategoryId, p.BrandId, p.IsActive,
                Images = p.Images.OrderBy(x => x.SortOrder).ThenBy(x => x.Id)
                    .Select(x => new { x.Id, x.Url, x.AltText, x.SortOrder }).ToList(),
                Variants = p.Variants.OrderBy(v => v.Id).Select(v => new
                { v.Id, v.Sku, v.Size, v.Color, v.Price, v.StockQuantity, v.IsActive, v.RowVersion }).ToList()
            }).SingleOrDefaultAsync(cancellationToken);
        return product is null ? NotFound() : Ok(product);
    }

    [HttpPost]
    [ProducesResponseType(typeof(object), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Create(ProductRequest request, CancellationToken cancellationToken)
    {
        if (!await ValidReferences(request, cancellationToken)) return ValidationProblem(ModelState);
        var product = new Product();
        Apply(product, request);
        db.Products.Add(product);
        var error = await Save(cancellationToken);
        return error ?? CreatedAtAction(nameof(Detail), new { id = product.Id }, new { product.Id });
    }

    [HttpPut("{id:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Update(int id, ProductRequest request, CancellationToken cancellationToken)
    {
        var product = await db.Products.FindAsync([id], cancellationToken);
        if (product is null) return NotFound();
        if (!await ValidReferences(request, cancellationToken)) return ValidationProblem(ModelState);
        Apply(product, request);
        return await Save(cancellationToken) ?? NoContent();
    }

    [HttpPost("{id:int}/variants")]
    [ProducesResponseType(typeof(object), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> CreateVariant(int id, VariantRequest request, CancellationToken cancellationToken)
    {
        if (!await db.Products.AnyAsync(p => p.Id == id, cancellationToken)) return NotFound();
        var variant = new ProductVariant { ProductId = id };
        Apply(variant, request);
        db.ProductVariants.Add(variant);
        var error = await Save(cancellationToken);
        return error ?? CreatedAtAction(nameof(Detail), new { id }, new { variant.Id, variant.RowVersion });
    }

    [HttpPut("{id:int}/variants/{variantId:int}")]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> UpdateVariant(int id, int variantId, UpdateVariantRequest request, CancellationToken cancellationToken)
    {
        var variant = await db.ProductVariants.SingleOrDefaultAsync(v => v.Id == variantId && v.ProductId == id, cancellationToken);
        if (variant is null) return NotFound();
        db.Entry(variant).Property(v => v.RowVersion).OriginalValue = request.RowVersion;
        Apply(variant, request);
        // Force an UPDATE even when fields are unchanged, so a stale token is checked.
        db.Entry(variant).Property(v => v.StockQuantity).IsModified = true;
        var error = await Save(cancellationToken);
        return error ?? Ok(new { variant.Id, variant.RowVersion });
    }

    private async Task<bool> ValidReferences(ProductRequest request, CancellationToken cancellationToken)
    {
        if (!await db.Categories.AnyAsync(c => c.Id == request.CategoryId, cancellationToken))
            ModelState.AddModelError(nameof(request.CategoryId), "Danh mục không tồn tại.");
        if (!await db.Brands.AnyAsync(b => b.Id == request.BrandId, cancellationToken))
            ModelState.AddModelError(nameof(request.BrandId), "Thương hiệu không tồn tại.");
        return ModelState.IsValid;
    }

    private async Task<IActionResult?> Save(CancellationToken cancellationToken)
    {
        try { await db.SaveChangesAsync(cancellationToken); return null; }
        catch (DbUpdateConcurrencyException)
        { return Conflict(new { message = "Dữ liệu đã thay đổi. Hãy tải lại trước khi lưu." }); }
        catch (DbUpdateException ex) when (ex.InnerException is SqlException { Number: 2601 or 2627 })
        { return Conflict(new { message = "SKU hoặc tổ hợp size/màu đã tồn tại." }); }
        catch (DbUpdateException ex) when (ex.InnerException is SqlException { Number: 547 })
        { return Conflict(new { message = "Dữ liệu liên quan đã thay đổi hoặc ràng buộc dữ liệu không hợp lệ." }); }
    }

    private static void Apply(Product product, ProductRequest request)
    {
        product.Name = request.Name.Trim(); product.Description = request.Description.Trim();
        product.CategoryId = request.CategoryId; product.BrandId = request.BrandId; product.IsActive = request.IsActive;
    }

    private static void Apply(ProductVariant variant, VariantRequest request)
    {
        variant.Sku = request.Sku.Trim(); variant.Size = request.Size.Trim(); variant.Color = request.Color.Trim();
        variant.Price = request.Price; variant.StockQuantity = request.StockQuantity; variant.IsActive = request.IsActive;
    }
}

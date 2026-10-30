using System.ComponentModel.DataAnnotations;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Route("api/products")]
public class ProductsController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> List(
        [FromQuery, StringLength(100)] string? search,
        [FromQuery, Range(1, int.MaxValue)] int? categoryId,
        [FromQuery, Range(1, int.MaxValue)] int? brandId,
        [FromQuery, RegularExpression("^(id|newest|name|priceAsc|priceDesc)$")] string sortBy = "id",
        [FromQuery] bool inStockOnly = false,
        [FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10,
        CancellationToken cancellationToken = default)
    {
        var query = db.Products.AsNoTracking().Where(p => p.IsActive);
        if (!string.IsNullOrWhiteSpace(search))
            query = query.Where(p => p.Name.Contains(search.Trim()));
        if (categoryId.HasValue) query = query.Where(p => p.CategoryId == categoryId);
        if (brandId.HasValue) query = query.Where(p => p.BrandId == brandId);
        if (inStockOnly) query = query.Where(p => p.Variants.Any(v => v.IsActive && v.StockQuantity > 0));
        var total = await query.CountAsync(cancellationToken);
        // Always use Id as a tie-breaker so pagination remains deterministic.
        var ordered = sortBy switch
        {
            "newest" => query.OrderByDescending(p => p.Id),
            "name" => query.OrderBy(p => p.Name).ThenBy(p => p.Id),
            "priceAsc" => query.OrderBy(p => !p.Variants.Any(v => v.IsActive))
                .ThenBy(p => p.Variants.Where(v => v.IsActive).Min(v => (decimal?)v.Price)).ThenBy(p => p.Id),
            "priceDesc" => query.OrderByDescending(p => p.Variants.Where(v => v.IsActive).Min(v => (decimal?)v.Price)).ThenBy(p => p.Id),
            _ => query.OrderBy(p => p.Id)
        };
        var items = await ordered.Skip((page - 1) * pageSize).Take(pageSize)
            .Select(p => new
            {
                p.Id, p.Name, p.CategoryId, CategoryName = p.Category.Name,
                p.BrandId, BrandName = p.Brand.Name,
                ImageUrl = p.Images.OrderBy(x => x.SortOrder).ThenBy(x => x.Id).Select(x => x.Url).FirstOrDefault(),
                MinPrice = p.Variants.Where(v => v.IsActive).Select(v => (decimal?)v.Price).Min(),
                StockQuantity = p.Variants.Where(v => v.IsActive).Sum(v => (long)v.StockQuantity)
            }).ToListAsync(cancellationToken);
        return Ok(new { items, total, page, pageSize, totalPages = (int)Math.Ceiling(total / (double)pageSize) });
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> Detail(int id, CancellationToken cancellationToken)
    {
        var product = await db.Products.AsNoTracking().Where(p => p.Id == id && p.IsActive)
            .Select(p => new
            {
                p.Id, p.Name, p.Description, p.CategoryId, CategoryName = p.Category.Name,
                p.BrandId, BrandName = p.Brand.Name,
                Images = p.Images.OrderBy(x => x.SortOrder).ThenBy(x => x.Id)
                    .Select(x => new { x.Id, x.Url, x.AltText, x.SortOrder }).ToList(),
                Variants = p.Variants.Where(v => v.IsActive).OrderBy(v => v.Id)
                    .Select(v => new { v.Id, v.Sku, v.Size, v.Color, v.Price, v.StockQuantity }).ToList()
            }).SingleOrDefaultAsync(cancellationToken);
        return product is null ? NotFound() : Ok(product);
    }
}

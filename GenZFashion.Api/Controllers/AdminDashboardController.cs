using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Admin")]
[Route("api/admin/dashboard")]
public class AdminDashboardController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Get(CancellationToken ct)
    {
        var totalProducts = await db.Products.CountAsync(ct);
        var activeProducts = await db.Products.CountAsync(p => p.IsActive, ct);
        var groups = await db.Orders.AsNoTracking().GroupBy(o => o.Status)
            .Select(g => new { Status = g.Key, Count = g.Count(), Total = g.Sum(o => o.Total) }).ToListAsync(ct);
        var ordersByStatus = Enum.GetValues<OrderStatus>().ToDictionary(
            status => status.ToString(), status => groups.FirstOrDefault(g => g.Status == status)?.Count ?? 0);
        var completedRevenue = groups.FirstOrDefault(g => g.Status == OrderStatus.Completed)?.Total ?? 0m;
        var lowStockQuery = db.ProductVariants.AsNoTracking()
            .Where(v => v.IsActive && v.Product.IsActive && v.StockQuantity <= 5);
        var lowStockCount = await lowStockQuery.CountAsync(ct);
        var lowStockVariants = await lowStockQuery.OrderBy(v => v.StockQuantity).ThenBy(v => v.Id).Take(20)
            .Select(v => new
            {
                v.Id, v.ProductId, ProductName = v.Product.Name, v.Sku, v.Size, v.Color, v.StockQuantity
            }).ToListAsync(ct);
        return Ok(new
        {
            generatedAt = DateTime.UtcNow, currency = "VND", totalProducts, activeProducts,
            hiddenProducts = totalProducts - activeProducts,
            totalOrders = groups.Sum(g => g.Count), ordersByStatus, completedRevenue,
            lowStockThreshold = 5, lowStockCount, lowStockVariants
        });
    }
}

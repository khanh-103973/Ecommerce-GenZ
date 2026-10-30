using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Authorize(Roles = "Admin")]
[ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
[ProducesResponseType(typeof(ProblemDetails), 403, "application/problem+json", Description = "Tài khoản không có vai trò được yêu cầu.")]
[Route("api/admin/dashboard")]
public class AdminDashboardController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
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

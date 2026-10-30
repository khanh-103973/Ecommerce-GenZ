using System.Security.Claims;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Authorize(Roles = "Customer")]
[ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
[ProducesResponseType(typeof(ProblemDetails), 403, "application/problem+json", Description = "Tài khoản không có vai trò được yêu cầu.")]
[Route("api/cart")]
public class CartController(GenZFashionDbContext db, CommerceService commerce) : ControllerBase
{
    private string UserId => User.FindFirstValue("sub")!;

    [HttpGet]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    public async Task<IActionResult> Get(CancellationToken ct)
    {
        var items = await db.CartItems.AsNoTracking().Where(i => i.Cart.UserId == UserId).OrderBy(i => i.Id)
            .Select(i => new
            {
                i.ProductVariantId, i.Quantity, i.ProductVariant.Product.Name,
                i.ProductVariant.Sku, i.ProductVariant.Size, i.ProductVariant.Color,
                i.ProductVariant.Price, i.ProductVariant.StockQuantity,
                IsAvailable = i.ProductVariant.IsActive && i.ProductVariant.Product.IsActive && i.ProductVariant.StockQuantity >= i.Quantity
            }).ToListAsync(ct);
        return Ok(new { items, estimatedTotal = items.Sum(i => i.Price * i.Quantity) });
    }

    // PUT sets the absolute quantity; repeating it does not add more units.
    [HttpPut("items/{variantId:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Set(int variantId, CartItemRequest request, CancellationToken ct)
    {
        await commerce.SetItem(UserId, variantId, request.Quantity, ct);
        return NoContent();
    }

    [HttpDelete("items/{variantId:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Remove(int variantId, CancellationToken ct)
    {
        await commerce.RemoveItem(UserId, variantId, ct);
        return NoContent();
    }
}

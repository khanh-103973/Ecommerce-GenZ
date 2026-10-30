using System.Security.Claims;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Customer")]
[Route("api/cart")]
public class CartController(GenZFashionDbContext db, CommerceService commerce) : ControllerBase
{
    private string UserId => User.FindFirstValue("sub")!;

    [HttpGet]
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
    public async Task<IActionResult> Set(int variantId, CartItemRequest request, CancellationToken ct)
    {
        await commerce.SetItem(UserId, variantId, request.Quantity, ct);
        return NoContent();
    }

    [HttpDelete("items/{variantId:int}")]
    public async Task<IActionResult> Remove(int variantId, CancellationToken ct)
    {
        await commerce.RemoveItem(UserId, variantId, ct);
        return NoContent();
    }
}

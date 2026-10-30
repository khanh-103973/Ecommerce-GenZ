using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Admin")]
[Route("api/admin/products/{productId:int}/images")]
public class AdminProductImagesController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> List(int productId, CancellationToken ct)
    {
        if (!await db.Products.AnyAsync(p => p.Id == productId, ct)) return NotFound();
        return Ok(await db.ProductImages.AsNoTracking().Where(x => x.ProductId == productId)
            .OrderBy(x => x.SortOrder).ThenBy(x => x.Id)
            .Select(x => new { x.Id, x.Url, x.AltText, x.SortOrder }).ToListAsync(ct));
    }

    [HttpPost]
    public async Task<IActionResult> Create(int productId, ProductImageRequest request, CancellationToken ct)
    {
        if (!await db.Products.AnyAsync(p => p.Id == productId, ct)) return NotFound();
        var image = new ProductImage { ProductId = productId };
        Apply(image, request);
        db.ProductImages.Add(image);
        await db.SaveChangesAsync(ct);
        return CreatedAtAction(nameof(List), new { productId }, new { image.Id, image.Url, image.AltText, image.SortOrder });
    }

    [HttpPut("{imageId:int}")]
    public async Task<IActionResult> Update(int productId, int imageId, ProductImageRequest request, CancellationToken ct)
    {
        var image = await db.ProductImages.SingleOrDefaultAsync(x => x.Id == imageId && x.ProductId == productId, ct);
        if (image is null) return NotFound();
        Apply(image, request);
        await db.SaveChangesAsync(ct);
        return NoContent();
    }

    [HttpDelete("{imageId:int}")]
    public async Task<IActionResult> Delete(int productId, int imageId, CancellationToken ct)
    {
        var image = await db.ProductImages.SingleOrDefaultAsync(x => x.Id == imageId && x.ProductId == productId, ct);
        if (image is null) return NotFound();
        db.ProductImages.Remove(image);
        await db.SaveChangesAsync(ct);
        return NoContent();
    }

    private static void Apply(ProductImage image, ProductImageRequest request)
    {
        image.Url = request.Url.Trim(); image.AltText = request.AltText.Trim(); image.SortOrder = request.SortOrder;
    }
}

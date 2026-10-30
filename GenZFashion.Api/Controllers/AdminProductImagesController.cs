using GenZFashion.Api.Contracts;
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
[Route("api/admin/products/{productId:int}/images")]
public class AdminProductImagesController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    public async Task<IActionResult> List(int productId, CancellationToken ct)
    {
        if (!await db.Products.AnyAsync(p => p.Id == productId, ct)) return NotFound();
        return Ok(await db.ProductImages.AsNoTracking().Where(x => x.ProductId == productId)
            .OrderBy(x => x.SortOrder).ThenBy(x => x.Id)
            .Select(x => new { x.Id, x.Url, x.AltText, x.SortOrder }).ToListAsync(ct));
    }

    [HttpPost]
    [ProducesResponseType(typeof(object), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
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
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Update(int productId, int imageId, ProductImageRequest request, CancellationToken ct)
    {
        var image = await db.ProductImages.SingleOrDefaultAsync(x => x.Id == imageId && x.ProductId == productId, ct);
        if (image is null) return NotFound();
        Apply(image, request);
        await db.SaveChangesAsync(ct);
        return NoContent();
    }

    [HttpDelete("{imageId:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
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

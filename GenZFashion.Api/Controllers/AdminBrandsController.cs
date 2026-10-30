using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Authorize(Roles = "Admin")]
[ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
[ProducesResponseType(typeof(ProblemDetails), 403, "application/problem+json", Description = "Tài khoản không có vai trò được yêu cầu.")]
[Route("api/admin/brands")]
public class AdminBrandsController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(typeof(IReadOnlyList<Brand>), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    public async Task<IActionResult> List(CancellationToken cancellationToken)
        => Ok(await db.Brands.AsNoTracking().OrderBy(x => x.Name).ToListAsync(cancellationToken));

    [HttpGet("{id:int}")]
    [ProducesResponseType(typeof(Brand), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    public async Task<IActionResult> Detail(int id, CancellationToken cancellationToken)
    {
        var item = await db.Brands.AsNoTracking().SingleOrDefaultAsync(x => x.Id == id, cancellationToken);
        return item is null ? NotFound() : Ok(item);
    }

    [HttpPost]
    [ProducesResponseType(typeof(Brand), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Create(LookupRequest request, CancellationToken cancellationToken)
    {
        var item = new Brand { Name = request.Name.Trim() };
        db.Brands.Add(item);
        var error = await Save(cancellationToken);
        return error ?? CreatedAtAction(nameof(Detail), new { id = item.Id }, item);
    }

    [HttpPut("{id:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Update(int id, LookupRequest request, CancellationToken cancellationToken)
    {
        var item = await db.Brands.FindAsync([id], cancellationToken);
        if (item is null) return NotFound();
        item.Name = request.Name.Trim();
        return await Save(cancellationToken) ?? NoContent();
    }

    [HttpDelete("{id:int}")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Delete(int id, CancellationToken cancellationToken)
    {
        var item = await db.Brands.FindAsync([id], cancellationToken);
        if (item is null) return NotFound();
        if (await db.Products.AnyAsync(p => p.BrandId == id, cancellationToken))
            return Conflict(new { message = "Đang có sản phẩm sử dụng, không thể xóa." });
        db.Brands.Remove(item);
        return await Save(cancellationToken) ?? NoContent();
    }

    private async Task<IActionResult?> Save(CancellationToken cancellationToken)
    {
        try { await db.SaveChangesAsync(cancellationToken); return null; }
        catch (DbUpdateConcurrencyException)
        { return Conflict(new { message = "Dữ liệu đã thay đổi. Hãy tải lại." }); }
        catch (DbUpdateException ex) when (ex.InnerException is SqlException { Number: 2601 or 2627 })
        { return Conflict(new { message = "Tên đã tồn tại." }); }
        catch (DbUpdateException ex) when (ex.InnerException is SqlException { Number: 547 })
        { return Conflict(new { message = "Đang có dữ liệu liên quan, không thể thực hiện." }); }
    }
}

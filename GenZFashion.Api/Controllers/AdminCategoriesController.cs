using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Admin")]
[Route("api/admin/categories")]
public class AdminCategoriesController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> List(CancellationToken cancellationToken)
        => Ok(await db.Categories.AsNoTracking().OrderBy(x => x.Name).ToListAsync(cancellationToken));

    [HttpGet("{id:int}")]
    public async Task<IActionResult> Detail(int id, CancellationToken cancellationToken)
    {
        var item = await db.Categories.AsNoTracking().SingleOrDefaultAsync(x => x.Id == id, cancellationToken);
        return item is null ? NotFound() : Ok(item);
    }

    [HttpPost]
    public async Task<IActionResult> Create(LookupRequest request, CancellationToken cancellationToken)
    {
        var item = new Category { Name = request.Name.Trim() };
        db.Categories.Add(item);
        var error = await Save(cancellationToken);
        return error ?? CreatedAtAction(nameof(Detail), new { id = item.Id }, item);
    }

    [HttpPut("{id:int}")]
    public async Task<IActionResult> Update(int id, LookupRequest request, CancellationToken cancellationToken)
    {
        var item = await db.Categories.FindAsync([id], cancellationToken);
        if (item is null) return NotFound();
        item.Name = request.Name.Trim();
        return await Save(cancellationToken) ?? NoContent();
    }

    [HttpDelete("{id:int}")]
    public async Task<IActionResult> Delete(int id, CancellationToken cancellationToken)
    {
        var item = await db.Categories.FindAsync([id], cancellationToken);
        if (item is null) return NotFound();
        if (await db.Products.AnyAsync(p => p.CategoryId == id, cancellationToken))
            return Conflict(new { message = "Đang có sản phẩm sử dụng, không thể xóa." });
        db.Categories.Remove(item);
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

using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Route("api/catalog")]
public class CatalogController(GenZFashionDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Get(CancellationToken ct)
    {
        var categories = await db.Categories.AsNoTracking().OrderBy(x => x.Name).Select(x => new { x.Id, x.Name }).ToListAsync(ct);
        var brands = await db.Brands.AsNoTracking().OrderBy(x => x.Name).Select(x => new { x.Id, x.Name }).ToListAsync(ct);
        return Ok(new { categories, brands });
    }
}

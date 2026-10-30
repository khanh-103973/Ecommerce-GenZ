using System.ComponentModel.DataAnnotations;
using GenZFashion.Api.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Admin")]
[Route("api/admin/customers")]
public class AdminCustomersController(GenZFashionDbContext db) : ControllerBase
{
    private IQueryable<ApplicationUser> Customers => db.Users.AsNoTracking().Where(u =>
        db.UserRoles.Any(ur => ur.UserId == u.Id && db.Roles.Any(r => r.Id == ur.RoleId && r.NormalizedName == "CUSTOMER")));

    [HttpGet]
    public async Task<IActionResult> List([FromQuery, StringLength(100)] string? search,
        [FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10, CancellationToken ct = default)
    {
        var query = Customers;
        if (!string.IsNullOrWhiteSpace(search))
        {
            var term = search.Trim();
            query = query.Where(u => u.FullName.Contains(term) || (u.Email != null && u.Email.Contains(term)));
        }
        var total = await query.CountAsync(ct);
        var items = await query.OrderBy(u => u.Id).Skip((page - 1) * pageSize).Take(pageSize)
            .Select(u => new
            {
                u.Id, u.FullName, u.Email,
                OrderCount = db.Orders.Count(o => o.UserId == u.Id),
                CompletedSpend = db.Orders.Where(o => o.UserId == u.Id && o.Status == OrderStatus.Completed)
                    .Sum(o => (decimal?)o.Total) ?? 0m
            }).ToListAsync(ct);
        return Ok(new { items, total, page, pageSize });
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> Detail(string id, CancellationToken ct)
    {
        var customer = await Customers.Where(u => u.Id == id).Select(u => new
        {
            u.Id, u.FullName, u.Email,
            OrderCount = db.Orders.Count(o => o.UserId == u.Id),
            CompletedOrderCount = db.Orders.Count(o => o.UserId == u.Id && o.Status == OrderStatus.Completed),
            CompletedSpend = db.Orders.Where(o => o.UserId == u.Id && o.Status == OrderStatus.Completed)
                .Sum(o => (decimal?)o.Total) ?? 0m
        }).SingleOrDefaultAsync(ct);
        return customer is null ? NotFound() : Ok(customer);
    }

    [HttpGet("{id}/orders")]
    public async Task<IActionResult> Orders(string id,
        [FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10, CancellationToken ct = default)
    {
        if (!await Customers.AnyAsync(u => u.Id == id, ct)) return NotFound();
        var query = db.Orders.AsNoTracking().Where(o => o.UserId == id);
        var total = await query.CountAsync(ct);
        var items = await query.OrderByDescending(o => o.Id).Skip((page - 1) * pageSize).Take(pageSize)
            .Select(o => new { o.Id, o.Total, o.Status, o.CreatedAt }).ToListAsync(ct);
        return Ok(new { items, total, page, pageSize });
    }
}

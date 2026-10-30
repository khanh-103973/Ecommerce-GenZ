using System.ComponentModel.DataAnnotations;
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
[Route("api/orders")]
public class OrdersController(GenZFashionDbContext db, CommerceService commerce) : ControllerBase
{
    private string UserId => User.FindFirstValue("sub")!;

    [HttpPost]
    public async Task<IActionResult> Checkout(CheckoutRequest request, CancellationToken ct)
    {
        var id = await commerce.Checkout(UserId, request, ct);
        return CreatedAtAction(nameof(Detail), new { id }, new { id });
    }

    [HttpGet]
    public async Task<IActionResult> List([FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10, CancellationToken ct = default)
    {
        var query = db.Orders.AsNoTracking().Where(o => o.UserId == UserId);
        var total = await query.CountAsync(ct);
        var items = await query.OrderByDescending(o => o.Id).Skip((page - 1) * pageSize).Take(pageSize)
            .Select(o => new { o.Id, o.Total, o.Status, o.CreatedAt }).ToListAsync(ct);
        return Ok(new { items, total, page, pageSize });
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> Detail(int id, CancellationToken ct)
    {
        var order = await OrderView.Project(db.Orders.AsNoTracking().Where(o => o.Id == id && o.UserId == UserId)).SingleOrDefaultAsync(ct);
        return order is null ? NotFound() : Ok(order);
    }

    [HttpPost("{id:int}/cancel")]
    public async Task<IActionResult> Cancel(int id, CancellationToken ct)
        => await commerce.ChangeStatus(id, UserId, OrderStatus.Cancelled, null, ct) ? NoContent() : NotFound();
}

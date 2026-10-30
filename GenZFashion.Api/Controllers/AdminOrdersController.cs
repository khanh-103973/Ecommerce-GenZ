using System.ComponentModel.DataAnnotations;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[Authorize(Roles = "Admin")]
[Route("api/admin/orders")]
public class AdminOrdersController(GenZFashionDbContext db, CommerceService commerce) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> List([FromQuery] OrderStatus? status,
        [FromQuery, Range(1, 1000000)] int page = 1,
        [FromQuery, Range(1, 100)] int pageSize = 10, CancellationToken ct = default)
    {
        if (status.HasValue && !Enum.IsDefined(status.Value)) return BadRequest();
        var query = db.Orders.AsNoTracking();
        if (status.HasValue) query = query.Where(o => o.Status == status);
        var total = await query.CountAsync(ct);
        var items = await query.OrderByDescending(o => o.Id).Skip((page - 1) * pageSize).Take(pageSize)
            .Select(o => new { o.Id, o.UserId, o.RecipientName, o.Total, o.Status, o.CreatedAt, o.RowVersion }).ToListAsync(ct);
        return Ok(new { items, total, page, pageSize });
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> Detail(int id, CancellationToken ct)
    {
        var order = await OrderView.Project(db.Orders.AsNoTracking().Where(o => o.Id == id)).SingleOrDefaultAsync(ct);
        return order is null ? NotFound() : Ok(order);
    }

    [HttpPut("{id:int}/status")]
    public async Task<IActionResult> Status(int id, OrderStatusRequest request, CancellationToken ct)
        => await commerce.ChangeStatus(id, null, request.Status, request.RowVersion, ct) ? NoContent() : NotFound();
}

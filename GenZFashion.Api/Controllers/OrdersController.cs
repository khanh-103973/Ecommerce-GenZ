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
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Authorize(Roles = "Customer")]
[ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
[ProducesResponseType(typeof(ProblemDetails), 403, "application/problem+json", Description = "Tài khoản không có vai trò được yêu cầu.")]
[Route("api/orders")]
public class OrdersController(GenZFashionDbContext db, CommerceService commerce) : ControllerBase
{
    private string UserId => User.FindFirstValue("sub")!;

    [HttpPost]
    [ProducesResponseType(typeof(object), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Checkout(CheckoutRequest request, CancellationToken ct)
    {
        var id = await commerce.Checkout(UserId, request, ct);
        return CreatedAtAction(nameof(Detail), new { id }, new { id });
    }

    [HttpGet]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ValidationProblemDetails), 400, "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
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
    [ProducesResponseType(typeof(OrderView), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    public async Task<IActionResult> Detail(int id, CancellationToken ct)
    {
        var order = await OrderView.Project(db.Orders.AsNoTracking().Where(o => o.Id == id && o.UserId == UserId)).SingleOrDefaultAsync(ct);
        return order is null ? NotFound() : Ok(order);
    }

    [HttpPost("{id:int}/cancel")]
    [ProducesResponseType(204, Description = "Thành công; không có nội dung phản hồi.")]
    [ProducesResponseType(typeof(ProblemDetails), 404, "application/problem+json", Description = "Không tồn tại hoặc không thuộc phạm vi truy cập của tài khoản.")]
    [ProducesResponseType(typeof(ProblemDetails), 409, "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    public async Task<IActionResult> Cancel(int id, CancellationToken ct)
        => await commerce.ChangeStatus(id, UserId, OrderStatus.Cancelled, null, ct) ? NoContent() : NotFound();
}

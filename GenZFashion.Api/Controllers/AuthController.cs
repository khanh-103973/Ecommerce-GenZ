using System.Security.Claims;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Controllers;

[ApiController]
[ProducesResponseType(typeof(ProblemDetails), 500, "application/problem+json", Description = "Lỗi chưa xử lý; thông báo chung và traceId, không trả chi tiết nội bộ.")]
[Route("api/auth")]
public class AuthController(UserManager<ApplicationUser> users, SignInManager<ApplicationUser> signIn,
    GenZFashionDbContext db, JwtTokenService tokens) : ControllerBase
{
    [HttpPost("register")]
    [EnableRateLimiting("auth")]
    [ProducesResponseType(typeof(object), 201, "application/json", Description = "Đã tạo; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(object), 400, "application/json", "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(object), 409, "application/json", "application/problem+json", Description = "Dữ liệu xung đột; kiểm tra thông báo và tải lại trước khi thử lại.")]
    [ProducesResponseType(typeof(ProblemDetails), 429, "application/problem+json", Description = "Vượt 30 yêu cầu auth/phút/IP; thử lại sau một phút.")]
    public async Task<IActionResult> Register(RegisterRequest request)
    {
        await using var transaction = await db.Database.BeginTransactionAsync();
        var email = request.Email.Trim();
        var user = new ApplicationUser { UserName = email, Email = email, FullName = request.FullName.Trim() };
        try
        {
            var result = await users.CreateAsync(user, request.Password);
            if (!result.Succeeded)
                return BadRequest(new { errors = result.Errors.Select(e => new { e.Code, e.Description }) });
            var roleResult = await users.AddToRoleAsync(user, "Customer");
            if (!roleResult.Succeeded) throw new InvalidOperationException("Cannot assign Customer role.");
            await transaction.CommitAsync();
            return StatusCode(201, new { user.Id, user.Email, user.FullName, role = "Customer" });
        }
        catch (DbUpdateException ex) when (ex.InnerException is SqlException { Number: 2601 or 2627 })
        { return Conflict(new { message = "Email đã được sử dụng." }); }
    }

    [HttpPost("login")]
    [EnableRateLimiting("auth")]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(object), 400, "application/json", "application/problem+json", Description = "Dữ liệu hoặc tham số không hợp lệ.")]
    [ProducesResponseType(typeof(object), 401, "application/json", "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
    [ProducesResponseType(typeof(ProblemDetails), 429, "application/problem+json", Description = "Vượt 30 yêu cầu auth/phút/IP; thử lại sau một phút.")]
    public async Task<IActionResult> Login(LoginRequest request)
    {
        var user = await users.FindByEmailAsync(request.Email.Trim());
        if (user is null) return Unauthorized(new { message = "Email hoặc mật khẩu không đúng." });
        var result = await signIn.CheckPasswordSignInAsync(user, request.Password, lockoutOnFailure: true);
        if (!result.Succeeded) return Unauthorized(new { message = "Không thể đăng nhập. Kiểm tra thông tin hoặc thử lại sau." });
        Response.Headers.CacheControl = "no-store";
        return Ok(tokens.Create(user, await users.GetRolesAsync(user)));
    }

    [Authorize]
    [HttpGet("me")]
    [ProducesResponseType(typeof(object), 200, "application/json", Description = "Thành công; trả dữ liệu JSON.")]
    [ProducesResponseType(typeof(ProblemDetails), 401, "application/problem+json", Description = "Chưa đăng nhập, thông tin đăng nhập sai hoặc token hết hạn.")]
    public async Task<IActionResult> Me()
    {
        var user = await users.FindByIdAsync(User.FindFirstValue("sub")!);
        return user is null ? Unauthorized() : Ok(new
        { user.Id, user.Email, user.FullName, roles = await users.GetRolesAsync(user) });
    }
}

using GenZFashion.Api.Data;
using Microsoft.EntityFrameworkCore;
using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.Threading.RateLimiting;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(options => options.Filters.Add<GenZFashion.Api.Filters.CommerceExceptionFilter>())
    .AddJsonOptions(options => options.JsonSerializerOptions.Converters.Add(new System.Text.Json.Serialization.JsonStringEnumConverter(allowIntegerValues: false)));
builder.Services.AddScoped<CommerceService>();
builder.Services.AddProblemDetails(options => options.CustomizeProblemDetails = context =>
    context.ProblemDetails.Extensions["traceId"] = context.HttpContext.TraceIdentifier);
builder.Services.AddDbContext<GenZFashionDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("GenZFashionDb")
        ?? throw new InvalidOperationException("ConnectionStrings:GenZFashionDb is required.")));
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi(options => options.AddDocumentTransformer<GenZFashion.Api.Services.BearerDocumentTransformer>());

builder.Services.AddIdentityCore<ApplicationUser>(options =>
{
    options.User.RequireUniqueEmail = true;
    options.Password.RequiredLength = 10;
    options.Lockout.MaxFailedAccessAttempts = 5;
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
}).AddRoles<IdentityRole>().AddEntityFrameworkStores<GenZFashionDbContext>().AddSignInManager().AddDefaultTokenProviders();

var signingKey = builder.Configuration["Jwt:SigningKey"];
if (string.IsNullOrWhiteSpace(signingKey) || Encoding.UTF8.GetByteCount(signingKey) < 32)
    throw new InvalidOperationException("Set Jwt:SigningKey (at least 32 bytes) in User Secrets or environment configuration.");
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
{
    options.MapInboundClaims = false;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true, ValidIssuer = JwtTokenService.Issuer,
        ValidateAudience = true, ValidAudience = JwtTokenService.Audience,
        ValidateLifetime = true, RequireExpirationTime = true,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(signingKey)),
        ValidAlgorithms = [SecurityAlgorithms.HmacSha256],
        NameClaimType = "sub", RoleClaimType = "role", ClockSkew = TimeSpan.Zero
    };
});
builder.Services.AddAuthorization();
builder.Services.AddScoped<JwtTokenService>();
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddPolicy("auth", context => RateLimitPartition.GetFixedWindowLimiter(
        context.Connection.RemoteIpAddress?.ToString() ?? "unknown",
        _ => new FixedWindowRateLimiterOptions { PermitLimit = 30, Window = TimeSpan.FromMinutes(1), QueueLimit = 0 }));
});

var app = builder.Build();

if (args.Contains("--bootstrap-admin"))
{
    await AdminBootstrap.RunAsync(app, args.Contains("--reset-local-admin-password"));
    return;
}

// Configure the HTTP request pipeline.
// Return a safe JSON error instead of exception details, including in local Development.
app.UseExceptionHandler(errorApp => errorApp.Run(context =>
    Results.Problem(statusCode: StatusCodes.Status500InternalServerError,
        title: "Lỗi xử lý yêu cầu",
        detail: "Không thể xử lý yêu cầu lúc này. Vui lòng thử lại sau.",
        extensions: new Dictionary<string, object?> { ["traceId"] = context.TraceIdentifier })
        .ExecuteAsync(context)));
app.UseStatusCodePages(async statusContext =>
{
    var context = statusContext.HttpContext;
    if (!context.Request.Path.StartsWithSegments("/api")) return;
    var (title, detail) = context.Response.StatusCode switch
    {
        400 => ("Yêu cầu không hợp lệ", "Kiểm tra dữ liệu gửi lên và thử lại."),
        401 => ("Chưa xác thực", "Vui lòng đăng nhập lại."),
        403 => ("Không có quyền truy cập", "Tài khoản không có quyền thực hiện thao tác này."),
        404 => ("Không tìm thấy dữ liệu", "Dữ liệu không tồn tại hoặc bạn không có quyền truy cập."),
        429 => ("Quá nhiều yêu cầu", "Bạn thao tác quá nhanh. Vui lòng thử lại sau một phút."),
        _ => ("Không thể thực hiện yêu cầu", "Vui lòng kiểm tra yêu cầu và thử lại.")
    };
    await Results.Problem(statusCode: context.Response.StatusCode, title: title, detail: detail,
        extensions: new Dictionary<string, object?> { ["traceId"] = context.TraceIdentifier })
        .ExecuteAsync(context);
});
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/openapi/v1.json", "GenZ Fashion API v1");
        options.RoutePrefix = "swagger";
        options.DocumentTitle = "GenZ Fashion - API testing";
    });
    app.MapGet("/health/database", async (GenZFashionDbContext db, CancellationToken cancellationToken) =>
        await db.Database.CanConnectAsync(cancellationToken)
            ? Results.Ok(new { status = "Connected" })
            : Results.StatusCode(StatusCodes.Status503ServiceUnavailable));
}

app.UseHttpsRedirection();
app.UseRateLimiter();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

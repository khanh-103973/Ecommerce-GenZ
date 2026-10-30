using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;

namespace GenZFashion.Api.Data;

public static class AdminBootstrap
{
    public static async Task RunAsync(WebApplication app, bool resetPassword = false)
    {
        if (!app.Environment.IsDevelopment()) throw new InvalidOperationException("Bootstrap is local Development only.");
        var connection = new SqlConnectionStringBuilder(app.Configuration.GetConnectionString("GenZFashionDb"));
        if (connection.DataSource != @"KHANHS\SQLEXPRESS" || connection.InitialCatalog != "GenZFashionDb")
            throw new InvalidOperationException("Unexpected bootstrap database.");
        using var scope = app.Services.CreateScope();
        var users = scope.ServiceProvider.GetRequiredService<UserManager<ApplicationUser>>();
        var db = scope.ServiceProvider.GetRequiredService<GenZFashionDbContext>();
        var email = app.Configuration["BootstrapAdmin:Email"] ?? throw new InvalidOperationException("BootstrapAdmin:Email is required.");
        var password = app.Configuration["BootstrapAdmin:Password"] ?? throw new InvalidOperationException("BootstrapAdmin:Password is required.");
        var existing = await users.FindByEmailAsync(email);
        if (existing is not null)
        {
            if (!await users.IsInRoleAsync(existing, "Admin"))
                throw new InvalidOperationException("Refusing to promote an existing non-admin account.");
            if (resetPassword)
            {
                var token = await users.GeneratePasswordResetTokenAsync(existing);
                var reset = await users.ResetPasswordAsync(existing, token, password);
                if (!reset.Succeeded)
                    throw new InvalidOperationException(string.Join("; ", reset.Errors.Select(e => e.Description)));
                Console.WriteLine("Local admin password reset successfully.");
                return;
            }
            Console.WriteLine("Admin already exists. No changes.");
            return;
        }
        await using var transaction = await db.Database.BeginTransactionAsync();
        var user = new ApplicationUser { UserName = email, Email = email, FullName = "Local demo administrator" };
        var result = await users.CreateAsync(user, password);
        if (!result.Succeeded) throw new InvalidOperationException(string.Join("; ", result.Errors.Select(e => e.Description)));
        result = await users.AddToRoleAsync(user, "Admin");
        if (!result.Succeeded) throw new InvalidOperationException("Cannot assign Admin role.");
        await transaction.CommitAsync();
        Console.WriteLine("Local admin created. Credentials are in User Secrets.");
    }
}

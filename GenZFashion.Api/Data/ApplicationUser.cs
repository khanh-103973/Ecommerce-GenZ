using Microsoft.AspNetCore.Identity;

namespace GenZFashion.Api.Data;

public class ApplicationUser : IdentityUser
{
    public string FullName { get; set; } = "";
}

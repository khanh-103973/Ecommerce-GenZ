using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using GenZFashion.Api.Data;
using Microsoft.IdentityModel.Tokens;

namespace GenZFashion.Api.Services;

public class JwtTokenService(IConfiguration configuration)
{
    public const string Issuer = "GenZFashion.Api";
    public const string Audience = "GenZFashion.Client";

    public object Create(ApplicationUser user, IEnumerable<string> roles)
    {
        var expiresAt = DateTime.UtcNow.AddMinutes(30);
        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, user.Id),
            new(JwtRegisteredClaimNames.Email, user.Email!),
            new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };
        claims.AddRange(roles.Select(role => new Claim("role", role)));
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:SigningKey"]!));
        var token = new JwtSecurityToken(Issuer, Audience, claims,
            notBefore: DateTime.UtcNow, expires: expiresAt,
            signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256));
        return new { accessToken = new JwtSecurityTokenHandler().WriteToken(token), tokenType = "Bearer", expiresAt };
    }
}

using System.ComponentModel.DataAnnotations;

namespace GenZFashion.Api.Contracts;

public class LoginRequest
{
    [Required, EmailAddress, StringLength(256)] public string Email { get; set; } = "";
    [Required, StringLength(128)] public string Password { get; set; } = "";
}

public class RegisterRequest : LoginRequest
{
    [Required, StringLength(100)] public string FullName { get; set; } = "";
}

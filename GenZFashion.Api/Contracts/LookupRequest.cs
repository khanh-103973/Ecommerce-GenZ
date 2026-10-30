using System.ComponentModel.DataAnnotations;

namespace GenZFashion.Api.Contracts;

public class LookupRequest
{
    [Required, StringLength(100)]
    public string Name { get; set; } = "";
}

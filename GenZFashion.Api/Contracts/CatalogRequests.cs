using System.ComponentModel.DataAnnotations;

namespace GenZFashion.Api.Contracts;

public class ProductRequest
{
    [Required, StringLength(200)] public string Name { get; set; } = "";
    [Required(AllowEmptyStrings = true), StringLength(4000)] public string Description { get; set; } = "";
    [Range(1, int.MaxValue)] public int CategoryId { get; set; }
    [Range(1, int.MaxValue)] public int BrandId { get; set; }
    public bool IsActive { get; set; } = true;
}

public class VariantRequest : IValidatableObject
{
    [Required, StringLength(64)] public string Sku { get; set; } = "";
    [Required, StringLength(20)] public string Size { get; set; } = "";
    [Required, StringLength(50)] public string Color { get; set; } = "";
    [Range(typeof(decimal), "0", "999999999999999999")] public decimal Price { get; set; }
    [Range(0, int.MaxValue)] public int StockQuantity { get; set; }
    public bool IsActive { get; set; } = true;

    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        if (Price != decimal.Truncate(Price))
            yield return new ValidationResult("Giá VND phải là số nguyên.", [nameof(Price)]);
    }
}

public class UpdateVariantRequest : VariantRequest
{
    [Required, MinLength(8), MaxLength(8)] public byte[] RowVersion { get; set; } = [];
}

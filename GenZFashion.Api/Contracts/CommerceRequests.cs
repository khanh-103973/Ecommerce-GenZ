using System.ComponentModel.DataAnnotations;
using GenZFashion.Api.Data;

namespace GenZFashion.Api.Contracts;

public class CartItemRequest
{
    [Range(1, 99)] public int Quantity { get; set; }
}

public class CheckoutRequest : IValidatableObject
{
    public Guid RequestId { get; set; }
    [Required, StringLength(100)] public string RecipientName { get; set; } = "";
    [Required, RegularExpression(@"\+?[0-9]{9,15}")] public string Phone { get; set; } = "";
    [Required, StringLength(500)] public string Address { get; set; } = "";
    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        if (RequestId == Guid.Empty) yield return new ValidationResult("RequestId phải là GUID khác rỗng.", [nameof(RequestId)]);
    }
}

public class OrderStatusRequest
{
    [EnumDataType(typeof(OrderStatus))] public OrderStatus Status { get; set; }
    [Required, MinLength(8), MaxLength(8)] public byte[] RowVersion { get; set; } = [];
}

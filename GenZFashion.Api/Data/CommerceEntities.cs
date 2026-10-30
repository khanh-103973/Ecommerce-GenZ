namespace GenZFashion.Api.Data;

public class Cart
{
    public int Id { get; set; }
    public string UserId { get; set; } = "";
    public ApplicationUser User { get; set; } = null!;
    public DateTime UpdatedAt { get; set; }
    public byte[] RowVersion { get; set; } = [];
    public List<CartItem> Items { get; set; } = [];
}

public class CartItem
{
    public int Id { get; set; }
    public int CartId { get; set; }
    public Cart Cart { get; set; } = null!;
    public int ProductVariantId { get; set; }
    public ProductVariant ProductVariant { get; set; } = null!;
    public int Quantity { get; set; }
}

public enum OrderStatus { Pending, Confirmed, Shipping, Completed, Cancelled }

public class Order
{
    public int Id { get; set; }
    public string UserId { get; set; } = "";
    public ApplicationUser User { get; set; } = null!;
    public Guid RequestId { get; set; }
    public string RecipientName { get; set; } = "";
    public string Phone { get; set; } = "";
    public string Address { get; set; } = "";
    public string PaymentMethod { get; set; } = "COD";
    public decimal Total { get; set; }
    public OrderStatus Status { get; set; } = OrderStatus.Pending;
    public DateTime CreatedAt { get; set; }
    public byte[] RowVersion { get; set; } = [];
    public List<OrderItem> Items { get; set; } = [];
}

public class OrderItem
{
    public int Id { get; set; }
    public int OrderId { get; set; }
    public Order Order { get; set; } = null!;
    public int ProductVariantId { get; set; }
    public ProductVariant ProductVariant { get; set; } = null!;
    public string ProductName { get; set; } = "";
    public string Sku { get; set; } = "";
    public string Size { get; set; } = "";
    public string Color { get; set; } = "";
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; }
}

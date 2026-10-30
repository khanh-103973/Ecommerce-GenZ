using GenZFashion.Api.Data;

namespace GenZFashion.Api.Contracts;

public record OrderLineView(int ProductVariantId, string ProductName, string Sku, string Size, string Color, decimal UnitPrice, int Quantity);
public record OrderView(int Id, string UserId, string RecipientName, string Phone, string Address,
    string PaymentMethod, decimal Total, OrderStatus Status, DateTime CreatedAt, byte[] RowVersion, List<OrderLineView> Items)
{
    public static IQueryable<OrderView> Project(IQueryable<Order> query) => query.Select(o => new OrderView(
        o.Id, o.UserId, o.RecipientName, o.Phone, o.Address, o.PaymentMethod, o.Total, o.Status, o.CreatedAt, o.RowVersion,
        o.Items.OrderBy(i => i.Id).Select(i => new OrderLineView(i.ProductVariantId, i.ProductName, i.Sku, i.Size, i.Color, i.UnitPrice, i.Quantity)).ToList()));
}

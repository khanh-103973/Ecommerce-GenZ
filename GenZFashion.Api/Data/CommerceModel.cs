using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Data;

public static class CommerceModel
{
    public static void Configure(ModelBuilder model)
    {
        var cart = model.Entity<Cart>();
        cart.HasIndex(x => x.UserId).IsUnique();
        cart.HasOne(x => x.User).WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
        cart.Property(x => x.RowVersion).IsRowVersion();
        var ci = model.Entity<CartItem>();
        ci.HasIndex(x => new { x.CartId, x.ProductVariantId }).IsUnique();
        ci.HasOne(x => x.Cart).WithMany(x => x.Items).HasForeignKey(x => x.CartId);
        ci.HasOne(x => x.ProductVariant).WithMany().HasForeignKey(x => x.ProductVariantId).OnDelete(DeleteBehavior.Restrict);
        ci.ToTable(t => t.HasCheckConstraint("CK_CartItems_Quantity", "[Quantity] BETWEEN 1 AND 99"));
        var order = model.Entity<Order>();
        order.HasIndex(x => new { x.UserId, x.RequestId }).IsUnique();
        order.HasIndex(x => x.CreatedAt);
        order.Property(x => x.RowVersion).IsRowVersion();
        order.HasOne(x => x.User).WithMany().HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.Restrict);
        order.Property(x => x.RecipientName).HasMaxLength(100).IsRequired();
        order.Property(x => x.Phone).HasMaxLength(20).IsRequired();
        order.Property(x => x.Address).HasMaxLength(500).IsRequired();
        order.Property(x => x.PaymentMethod).HasMaxLength(10).IsRequired();
        order.Property(x => x.Status).HasConversion<string>().HasMaxLength(20);
        order.Property(x => x.Total).HasPrecision(18, 0);
        order.ToTable(t =>
        {
            t.HasCheckConstraint("CK_Orders_Total", "[Total] >= 0");
            t.HasCheckConstraint("CK_Orders_Payment", "[PaymentMethod] = 'COD'");
            t.HasCheckConstraint("CK_Orders_Status", "[Status] IN ('Pending','Confirmed','Shipping','Completed','Cancelled')");
        });
        var oi = model.Entity<OrderItem>();
        oi.HasOne(x => x.Order).WithMany(x => x.Items).HasForeignKey(x => x.OrderId);
        oi.HasOne(x => x.ProductVariant).WithMany().HasForeignKey(x => x.ProductVariantId).OnDelete(DeleteBehavior.Restrict);
        oi.Property(x => x.ProductName).HasMaxLength(200).IsRequired();
        oi.Property(x => x.Sku).HasMaxLength(64).IsRequired();
        oi.Property(x => x.Size).HasMaxLength(20).IsRequired();
        oi.Property(x => x.Color).HasMaxLength(50).IsRequired();
        oi.Property(x => x.UnitPrice).HasPrecision(18, 0);
        oi.ToTable(t =>
        {
            t.HasCheckConstraint("CK_OrderItems_Quantity", "[Quantity] BETWEEN 1 AND 99");
            t.HasCheckConstraint("CK_OrderItems_Price", "[UnitPrice] >= 0");
        });
    }
}

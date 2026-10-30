using System.Data;
using GenZFashion.Api.Contracts;
using GenZFashion.Api.Data;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Services;

public class CommerceConflictException(string message) : Exception(message);

public class CommerceService(GenZFashionDbContext db)
{
    public async Task SetItem(string userId, int variantId, int quantity, CancellationToken ct)
    {
        await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.Serializable, ct);
        var cart = await db.Carts.Include(x => x.Items).SingleOrDefaultAsync(x => x.UserId == userId, ct);
        var variant = await db.ProductVariants.Include(x => x.Product).SingleOrDefaultAsync(x => x.Id == variantId, ct);
        if (variant is null || !variant.IsActive || !variant.Product.IsActive)
            throw new CommerceConflictException("Sản phẩm không còn bán.");
        if (quantity > variant.StockQuantity) throw new CommerceConflictException("Không đủ tồn kho.");
        if (cart is null) { cart = new Cart { UserId = userId }; db.Carts.Add(cart); }
        var item = cart.Items.SingleOrDefault(x => x.ProductVariantId == variantId);
        if (item is null)
        {
            if (cart.Items.Count >= 50) throw new CommerceConflictException("Giỏ hàng tối đa 50 biến thể.");
            cart.Items.Add(new CartItem { ProductVariantId = variantId, Quantity = quantity });
        }
        else item.Quantity = quantity;
        cart.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);
    }

    public async Task RemoveItem(string userId, int variantId, CancellationToken ct)
    {
        await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.Serializable, ct);
        var cart = await db.Carts.Include(x => x.Items).SingleOrDefaultAsync(x => x.UserId == userId, ct);
        var item = cart?.Items.SingleOrDefault(x => x.ProductVariantId == variantId);
        if (item is not null)
        {
            db.CartItems.Remove(item);
            cart!.UpdatedAt = DateTime.UtcNow;
            await db.SaveChangesAsync(ct);
        }
        await tx.CommitAsync(ct);
    }

    public async Task<int> Checkout(string userId, CheckoutRequest request, CancellationToken ct)
    {
        await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.Serializable, ct);
        var existing = await db.Orders.SingleOrDefaultAsync(x => x.UserId == userId && x.RequestId == request.RequestId, ct);
        if (existing is not null) return existing.Id;
        var cart = await db.Carts.Include(x => x.Items).ThenInclude(x => x.ProductVariant).ThenInclude(x => x.Product)
            .SingleOrDefaultAsync(x => x.UserId == userId, ct);
        if (cart is null || cart.Items.Count == 0) throw new CommerceConflictException("Giỏ hàng trống.");
        var order = new Order
        {
            UserId = userId, RequestId = request.RequestId, RecipientName = request.RecipientName.Trim(),
            Phone = request.Phone, Address = request.Address.Trim(), CreatedAt = DateTime.UtcNow
        };
        foreach (var item in cart.Items.OrderBy(x => x.ProductVariantId))
        {
            var variant = item.ProductVariant;
            if (!variant.IsActive || !variant.Product.IsActive || variant.StockQuantity < item.Quantity)
                throw new CommerceConflictException("Sản phẩm ngừng bán hoặc không đủ tồn kho. Hãy cập nhật giỏ hàng.");
            variant.StockQuantity -= item.Quantity;
            order.Items.Add(new OrderItem
            {
                ProductVariantId = variant.Id, ProductName = variant.Product.Name, Sku = variant.Sku,
                Size = variant.Size, Color = variant.Color, UnitPrice = variant.Price, Quantity = item.Quantity
            });
        }
        order.Total = order.Items.Sum(x => x.UnitPrice * x.Quantity);
        if (order.Total > 999999999999999999m) throw new CommerceConflictException("Tổng giá trị đơn vượt giới hạn.");
        db.Orders.Add(order);
        db.CartItems.RemoveRange(cart.Items);
        cart.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);
        return order.Id;
    }

    public async Task<bool> ChangeStatus(int id, string? ownerId, OrderStatus target, byte[]? rowVersion, CancellationToken ct)
    {
        await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.Serializable, ct);
        var order = await db.Orders.Include(x => x.Items).ThenInclude(x => x.ProductVariant)
            .SingleOrDefaultAsync(x => x.Id == id && (ownerId == null || x.UserId == ownerId), ct);
        if (order is null) return false;
        if (rowVersion is not null && !order.RowVersion.SequenceEqual(rowVersion))
            throw new CommerceConflictException("Đơn đã thay đổi. Hãy tải lại.");
        if (order.Status == OrderStatus.Cancelled && target == OrderStatus.Cancelled) return true;
        var allowed = (order.Status, target) switch
        {
            (OrderStatus.Pending, OrderStatus.Confirmed) => ownerId == null,
            (OrderStatus.Confirmed, OrderStatus.Shipping) => ownerId == null,
            (OrderStatus.Shipping, OrderStatus.Completed) => ownerId == null,
            (OrderStatus.Pending, OrderStatus.Cancelled) => true,
            (OrderStatus.Confirmed, OrderStatus.Cancelled) => ownerId == null,
            _ => false
        };
        if (!allowed) throw new CommerceConflictException("Không thể chuyển trạng thái đơn theo yêu cầu.");
        if (target == OrderStatus.Cancelled)
            foreach (var item in order.Items.OrderBy(x => x.ProductVariantId))
            {
                var newStock = (long)item.ProductVariant.StockQuantity + item.Quantity;
                if (newStock > int.MaxValue) throw new CommerceConflictException("Tồn kho vượt giới hạn.");
                item.ProductVariant.StockQuantity = (int)newStock;
            }
        order.Status = target;
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);
        return true;
    }
}

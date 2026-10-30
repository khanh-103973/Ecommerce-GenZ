using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace GenZFashion.Api.Data;

public class GenZFashionDbContext(DbContextOptions<GenZFashionDbContext> options)
    : IdentityDbContext<ApplicationUser>(options)
{
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Brand> Brands => Set<Brand>();
    public DbSet<Product> Products => Set<Product>();
    public DbSet<ProductVariant> ProductVariants => Set<ProductVariant>();
    public DbSet<ProductImage> ProductImages => Set<ProductImage>();
    public DbSet<Cart> Carts => Set<Cart>();
    public DbSet<CartItem> CartItems => Set<CartItem>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();

    protected override void OnModelCreating(ModelBuilder model)
    {
        base.OnModelCreating(model);
        CommerceModel.Configure(model);
        var image = model.Entity<ProductImage>();
        image.Property(x => x.Url).HasMaxLength(2048).IsRequired();
        image.Property(x => x.AltText).HasMaxLength(200).IsRequired();
        image.HasOne(x => x.Product).WithMany(x => x.Images).HasForeignKey(x => x.ProductId).OnDelete(DeleteBehavior.Cascade);
        image.HasIndex(x => new { x.ProductId, x.SortOrder, x.Id });
        image.ToTable(t => t.HasCheckConstraint("CK_ProductImages_SortOrder", "[SortOrder] >= 0"));
        model.Entity<ApplicationUser>().Property(x => x.FullName).HasMaxLength(100).IsRequired();
        model.Entity<ApplicationUser>().HasIndex(x => x.NormalizedEmail).IsUnique()
            .HasFilter("[NormalizedEmail] IS NOT NULL");
        model.Entity<IdentityRole>().HasData(
            new IdentityRole { Id = "genz-admin", Name = "Admin", NormalizedName = "ADMIN", ConcurrencyStamp = "genz-admin-v1" },
            new IdentityRole { Id = "genz-customer", Name = "Customer", NormalizedName = "CUSTOMER", ConcurrencyStamp = "genz-customer-v1" });
        model.Entity<Category>().Property(x => x.Name).HasMaxLength(100).IsRequired();
        model.Entity<Brand>().Property(x => x.Name).HasMaxLength(100).IsRequired();
        model.Entity<Category>().HasIndex(x => x.Name).IsUnique();
        model.Entity<Brand>().HasIndex(x => x.Name).IsUnique();
        var product = model.Entity<Product>();
        product.Property(x => x.Name).HasMaxLength(200).IsRequired();
        product.Property(x => x.Description).HasMaxLength(4000);
        product.HasOne(x => x.Category).WithMany().HasForeignKey(x => x.CategoryId).OnDelete(DeleteBehavior.Restrict);
        product.HasOne(x => x.Brand).WithMany().HasForeignKey(x => x.BrandId).OnDelete(DeleteBehavior.Restrict);
        var variant = model.Entity<ProductVariant>();
        variant.Property(x => x.Sku).HasMaxLength(64).IsRequired();
        variant.Property(x => x.Size).HasMaxLength(20).IsRequired();
        variant.Property(x => x.Color).HasMaxLength(50).IsRequired();
        variant.Property(x => x.Price).HasPrecision(18, 0);
        variant.Property(x => x.RowVersion).IsRowVersion();
        variant.HasIndex(x => x.Sku).IsUnique();
        variant.HasIndex(x => new { x.ProductId, x.Size, x.Color }).IsUnique();
        variant.HasOne(x => x.Product).WithMany(x => x.Variants).HasForeignKey(x => x.ProductId).OnDelete(DeleteBehavior.Restrict);
        variant.ToTable(t =>
        {
            t.HasCheckConstraint("CK_ProductVariants_Price", "[Price] >= 0");
            t.HasCheckConstraint("CK_ProductVariants_Stock", "[StockQuantity] >= 0");
        });
    }
}

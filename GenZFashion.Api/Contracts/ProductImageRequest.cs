using System.ComponentModel.DataAnnotations;

namespace GenZFashion.Api.Contracts;

public class ProductImageRequest : IValidatableObject
{
    [Required, StringLength(2048)] public string Url { get; set; } = "";
    [Required(AllowEmptyStrings = true), StringLength(200)] public string AltText { get; set; } = "";
    [Range(0, int.MaxValue)] public int SortOrder { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        if (!Uri.TryCreate(Url?.Trim(), UriKind.Absolute, out var uri)
            || uri.Scheme != Uri.UriSchemeHttps || string.IsNullOrWhiteSpace(uri.Host)
            || !string.IsNullOrEmpty(uri.UserInfo))
            yield return new ValidationResult("URL phải là HTTPS tuyệt đối, không chứa thông tin đăng nhập.", [nameof(Url)]);
    }
}

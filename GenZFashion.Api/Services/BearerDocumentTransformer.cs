using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.OpenApi;
using Microsoft.OpenApi;

namespace GenZFashion.Api.Services;

public class BearerDocumentTransformer : IOpenApiDocumentTransformer
{
    public Task TransformAsync(OpenApiDocument document, OpenApiDocumentTransformerContext context, CancellationToken cancellationToken)
    {
        document.Components ??= new OpenApiComponents();
        document.Components.SecuritySchemes ??= new Dictionary<string, IOpenApiSecurityScheme>();
        document.Components.SecuritySchemes["Bearer"] = new OpenApiSecurityScheme
        {
            Type = SecuritySchemeType.Http, Scheme = "bearer", BearerFormat = "JWT",
            Description = "Dán accessToken từ API login, không thêm tiền tố Bearer."
        };
        foreach (var description in context.DescriptionGroups.SelectMany(g => g.Items))
        {
            var metadata = description.ActionDescriptor.EndpointMetadata;
            if (!metadata.OfType<IAuthorizeData>().Any() || metadata.OfType<IAllowAnonymous>().Any()) continue;
            var path = "/" + description.RelativePath?.Split('?')[0];
            if (!document.Paths.TryGetValue(path, out var pathItem) || pathItem.Operations is null) continue;
            foreach (var operation in pathItem.Operations.Where(p => string.Equals(p.Key.ToString(), description.HttpMethod, StringComparison.OrdinalIgnoreCase)))
            {
                operation.Value.Security ??= [];
                operation.Value.Security.Add(new OpenApiSecurityRequirement
                { [new OpenApiSecuritySchemeReference("Bearer", document)] = [] });
            }
        }
        return Task.CompletedTask;
    }
}

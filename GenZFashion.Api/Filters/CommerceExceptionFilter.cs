using GenZFashion.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace GenZFashion.Api.Filters;

public class CommerceExceptionFilter : IExceptionFilter
{
    public void OnException(ExceptionContext context)
    {
        var ex = context.Exception;
        // SQL Server's execution strategy can wrap a deadlock inside InvalidOperationException.
        var conflict = ex is CommerceConflictException or DbUpdateConcurrencyException
            || ex.GetBaseException() is SqlException { Number: 1205 or 2601 or 2627 };
        if (!conflict) return;
        context.Result = new ObjectResult(new ProblemDetails
        {
            Status = 409, Title = "Xung đột dữ liệu",
            Detail = ex is CommerceConflictException ? ex.Message : "Dữ liệu vừa thay đổi. Tải lại và thử lại yêu cầu."
        }) { StatusCode = 409 };
        context.ExceptionHandled = true;
    }
}

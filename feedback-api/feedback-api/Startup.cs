using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

public static void ConfigureServices(IServiceCollection services)
{
    // ... other services
    services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = "YourIssuer",
            ValidAudience = "YourAudience",
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("Your_Secret_Key_Here"))
        };
    });

    services.AddAuthorization(options =>
    {
        options.AddPolicy("Admin", policy => policy.RequireClaim("UserRole", "Admin"));
        options.AddPolicy("Customer", policy => policy.RequireClaim("UserRole", "Customer"));
        options.AddPolicy("SuperUser", policy => policy.RequireClaim("UserRole", "SuperUser"));
    });
}


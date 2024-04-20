using feedback_api.Data;
using feedback_api.Models;
using feedback_api.utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace feedback_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;
       
        public UserController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("signup")]
        public async Task<IActionResult> SignUp(User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return Ok(new { user.Id, user.Username, user.Role });
        }

        [HttpPost("login")]
        public IActionResult Login(User user)
        {
            var existingUser = _context.Users.SingleOrDefault(u => u.Username == user.Username && u.PasswordHash == user.PasswordHash);
            if (existingUser == null) return Unauthorized();

            // Generate JWT token
            //var token = new JwtSecurityTokenHandler().WriteToken();
            var token = new GenerateJwtToken(existingUser);

            return Ok(new { Token = token });
        }

        [Authorize(Policy = "SuperUser")]
        [HttpPost("addAdmin")]
        public async Task<IActionResult> AddAdmin(User admin)
        {
            admin.Role = UserRole.Admin;
            _context.Users.Add(admin);
            await _context.SaveChangesAsync();
            return Ok(new { admin.Id, admin.Username });
        }

        [Authorize(Policy = "SuperUser")]
        [HttpDelete("deleteAdmin/{adminId}")]
        public async Task<IActionResult> DeleteAdmin(int adminId)
        {
            var admin = await _context.Users.FindAsync(adminId);
            if (admin == null || admin.Role != UserRole.Admin) return NotFound();

            _context.Users.Remove(admin);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [Authorize(Policy = "SuperUser")]
        [HttpPut("updateAdmin/{adminId}")]
        public async Task<IActionResult> UpdateAdmin(int adminId, User updatedAdmin)
        {
            var admin = await _context.Users.FindAsync(adminId);
            if (admin == null || admin.Role != UserRole.Admin) return NotFound();

            admin.Username = updatedAdmin.Username;
            admin.PasswordHash = updatedAdmin.PasswordHash;
            await _context.SaveChangesAsync();
            return Ok(new { admin.Id, admin.Username });
        }

        [Authorize(Policy = "SuperUser")]
        [HttpGet("viewAdmins")]
        public IActionResult ViewAdmins()
        {
            var admins = _context.Users.Where(u => u.Role == UserRole.Admin).ToList();
            return Ok(admins);
        }

        [Authorize(Policy = "SuperUser")]
        [HttpGet("viewFeedback")]
        public IActionResult ViewFeedback()
        {
            var feedbacks = _context.Feedbacks.Include(f => f.User).ToList();
            return Ok(feedbacks);
        }

        private string GenerateJwtToken(User user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("your_secret_key_here")); // Replace with your secret key
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
            new Claim(JwtRegisteredClaimNames.Sub, user.Username),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString())
        };

            var token = new JwtSecurityToken(
                issuer: "your_issuer_here", // Replace with your issuer
                audience: "your_audience_here", // Replace with your audience
                claims: claims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials: credentials
            );

            var tokenHandler = new JwtSecurityTokenHandler();
            var encodedToken = tokenHandler.WriteToken(token);

            return encodedToken;
        }
    }
}

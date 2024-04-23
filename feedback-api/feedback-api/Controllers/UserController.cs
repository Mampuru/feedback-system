using feedback_api.Data;
using feedback_api.Models;
using feedback_api.utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
            user.PasswordHash = PasswordHandler.HashPassword(user.PasswordHash);
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
            var token = Auth.GenerateJwtToken(existingUser);

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

    }
}

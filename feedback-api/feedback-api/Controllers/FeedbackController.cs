using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Linq;
using feedback_api.Data;
using feedback_api.Models;
using Microsoft.EntityFrameworkCore;

namespace feedback_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FeedbackController : ControllerBase
    {
        private readonly AppDbContext _context;

        public FeedbackController(AppDbContext context)
        {
            _context = context;
        }

        [Authorize(Policy = "Customer")]
        [HttpPost]
        public async Task<IActionResult> SubmitFeedback(Feedback feedback)
        {
            _context.Feedbacks.Add(feedback);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [Authorize(Policy = "Admin")]
        [HttpGet]
        public IActionResult GetFeedbacks()
        {
            var feedbacks = _context.Feedbacks.Include(f => f.User).ToList();
            return Ok(feedbacks);
        }
    }
}

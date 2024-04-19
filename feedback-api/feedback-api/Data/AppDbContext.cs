using feedback_api.Models;
using Microsoft.EntityFrameworkCore;

namespace feedback_api.Data
{
    

    public class AppDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Feedback> Feedbacks { get; set; }
        public DbSet<SuperUser> SuperUsers { get; set; }


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Your_Connection_String_Here");
        }
    }
}

﻿using feedback_api.Models;
using Microsoft.EntityFrameworkCore;

namespace feedback_api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options):base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Feedback> Feedbacks { get; set; }

    }
}

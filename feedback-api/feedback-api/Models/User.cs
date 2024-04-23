namespace feedback_api.Models
{
    public class User
    {
        public int Id { get; set; }
        public required string Username { get; set; }
        public required string PasswordHash { get; set; }
        public required string Email { get; set; }
        public UserRole Role { get; set; }
    }

    public enum UserRole
    {
        Admin,
        Customer,
        SuperUser
    }
}

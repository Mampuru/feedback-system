namespace feedback_api.Models
{
    public class UserDTO
    {
        public string? Username { get; set; }
        public required string Password { get; set; }
        public required string Email { get; set; }
        public UserRole Role { get; set; }

        public static User convertToUser(UserDTO user)
        {
            User x = new()
            {
                Username = user.Username,
                PasswordHash = user.Password,
                Email = user.Email,
                Role = user.Role
            };

            return x;
        }
    }

}


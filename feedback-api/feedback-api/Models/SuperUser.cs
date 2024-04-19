namespace feedback_api.Models
{
    public class SuperUser : User
    {
        public List<User> Admins { get; set; }
    }
}

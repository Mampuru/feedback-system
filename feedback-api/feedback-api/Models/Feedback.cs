namespace feedback_api.Models
{
    public class Feedback
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public FeedbackIndicator Indicator { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
    }

    public enum FeedbackIndicator
    {
        Success,
        Failure
    }
}

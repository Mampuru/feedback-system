using System.Security.Cryptography;
using System.Text;
using Konscious.Security.Cryptography;

namespace feedback_api.utils
{
    public class PasswordHandler
    {
        private const int SaltSize = 16; // 128 bits
        private const int HashSize = 16; // 128 bits
        private const int Iterations = 10000; // Recommended value by Argon2

        public static string HashPassword(string password)
        {
            // Generate a random salt
            byte[] salt = new byte[SaltSize];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            // Hash the password
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password))
            {
                Salt = salt,
                DegreeOfParallelism = 8,
                Iterations = Iterations,
                MemorySize = 4096 // 4MB
            };

            var hash = argon2.GetBytes(HashSize);

            // Combine salt and hash
            byte[] hashWithSalt = new byte[SaltSize + HashSize];
            Array.Copy(salt, 0, hashWithSalt, 0, SaltSize);
            Array.Copy(hash, 0, hashWithSalt, SaltSize, HashSize);

            return Convert.ToBase64String(hashWithSalt);
        }

        public static bool VerifyPassword(string hashedPassword, string password)
        {
            // Extract salt and hash from stored hash
            byte[] hashWithSalt = Convert.FromBase64String(hashedPassword);
            byte[] salt = new byte[SaltSize];
            byte[] hashStored = new byte[HashSize];

            Array.Copy(hashWithSalt, 0, salt, 0, SaltSize);
            Array.Copy(hashWithSalt, SaltSize, hashStored, 0, HashSize);

            // Compute the hash of the provided password
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password))
            {
                Salt = salt,
                DegreeOfParallelism = 8,
                Iterations = Iterations,
                MemorySize = 4096 // 4MB
            };

            var hashComputed = argon2.GetBytes(HashSize);

            // Compare the computed hash with the stored hash
            return hashStored.SequenceEqual(hashComputed);
        }
    }
}

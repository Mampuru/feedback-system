class User {
  final String id;
  final String email;
  final String username;
  final String role;

  User(this.username, this.role, {required this.id, required this.email});
}
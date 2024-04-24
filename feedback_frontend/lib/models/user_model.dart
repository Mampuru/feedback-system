class User {
  final String id;
  final String email;
  final String username;
  final String role;
  final String password;

  User(this.username, this.role, {required this.password,required this.id, required this.email});
}
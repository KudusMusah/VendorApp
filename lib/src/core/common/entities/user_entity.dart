class UserEntity {
  final String name;
  final String email;
  final String phone;
  final String role;
  final String resetCode;
  final String id;
  final String createdAt;
  final String updatedAt;
  final String token;
  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.resetCode,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });
}

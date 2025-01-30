import 'package:didi/src/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required super.resetCode,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.token,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? role,
    String? resetCode,
    String? id,
    String? createdAt,
    String? updatedAt,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      resetCode: resetCode ?? this.resetCode,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'resetCode': resetCode,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
      role: map['role'] ?? "",
      resetCode: map['resetCode'] ?? "",
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
      token: map['token'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserEntity(name: $name, email: $email, phone: $phone, role: $role, resetCode: $resetCode, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }
}

import 'dart:convert';

import 'package:didi/src/core/constants.dart';
import 'package:didi/src/core/errors/exceptions/auth_exception.dart';
import 'package:didi/src/features/auth/data/models/user_model.dart';
import 'package:http/http.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> registerWithEmailPassword(
    String email,
    String password,
    String name,
  );
  Future<UserModel> loginWithEmailPassword(String email, String password);
  Future<void> forgotPassword(String email);
  Future<UserModel> verifyCode(String email, String resetCode);
  Future<UserModel> changePassword(
    String email,
    String resetCode,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client _httpClient;
  AuthRemoteDataSourceImpl({
    required Client httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<UserModel> changePassword(
    String email,
    String resetCode,
    String password,
  ) async {
    try {
      final body = jsonEncode({
        'email': email,
        'resetCode': int.parse(resetCode),
        'newPassword': password,
      });

      final response = await _httpClient.post(
        Uri.parse("${Constants.authEndpoint}/change_password"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        throw AuthException(
          message: resMap["error"] ??
              resMap["message"] ??
              "An unexpected error occured",
          code: response.statusCode.toString(),
        );
      }
      final resMap = jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(
        resMap["user"],
      ).copyWith(token: resMap["token"]);
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: "An unexpected Error occured");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final body = jsonEncode({
        'email': email,
      });

      final response = await _httpClient.post(
        Uri.parse("${Constants.authEndpoint}/forget_password"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 204) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        throw AuthException(
          message: resMap["error"] ??
              resMap["message"] ??
              "An unexpected error occured",
          code: response.statusCode.toString(),
        );
      }
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: "An unexpected Error occured");
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final body = jsonEncode({
        'email': email,
        'password': password,
      });

      final response = await _httpClient.post(
        Uri.parse("${Constants.authEndpoint}/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        throw AuthException(
          message: resMap["error"] ??
              resMap["message"] ??
              "An unexpected error occured",
          code: response.statusCode.toString(),
        );
      }

      final resMap = jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(
        resMap["user"],
      ).copyWith(token: resMap["token"]);
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: "An unexpected Error occured");
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phone': '+233246027827',
        'role': 'vendor',
      });

      final response = await _httpClient.post(
        Uri.parse("${Constants.authEndpoint}/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 201) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        throw AuthException(
          message: resMap["error"] ??
              resMap["message"] ??
              "An unexpected error occured",
          code: response.statusCode.toString(),
        );
      }

      final resMap = jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(resMap["user"]);
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: "An unexpected Error occured");
    }
  }

  @override
  Future<UserModel> verifyCode(String email, String resetCode) async {
    try {
      final body = jsonEncode({
        'email': email,
        'resetCode': int.parse(resetCode),
      });

      final response = await _httpClient.post(
        Uri.parse("${Constants.authEndpoint}/verify_code"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        throw AuthException(
          message: resMap["error"] ??
              resMap["message"] ??
              "An unexpected error occured",
          code: response.statusCode.toString(),
        );
      }

      final resMap = jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(resMap);
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: "An unexpected Error occured");
    }
  }
}

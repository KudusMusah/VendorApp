import 'package:didi/src/core/errors/exceptions/auth_exception.dart';
import 'package:didi/src/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

abstract interface class AuthLocalDataSource {
  void storeLoggedInUserInfo(UserModel user);
  Future<UserModel> getLoggedInUserInfo();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _hiveBox;

  AuthLocalDataSourceImpl({
    required Box hiveBox,
  }) : _hiveBox = hiveBox;

  @override
  Future<UserModel> getLoggedInUserInfo() async {
    try {
      final user = await _hiveBox.get("loggedInUser");
      final tokenExpires = await _hiveBox.get("tokenExpires");

      final expirationDate = DateTime.parse(tokenExpires);
      final isExpired = DateTime.now().isAfter(expirationDate);

      if (user == null || isExpired) {
        throw AuthException(message: "User is not loggenIn");
      }
      return UserModel.fromJson(user);
    } catch (e) {
      if (e is AuthException) {
        throw AuthException(message: e.message, code: e.code);
      }
      throw AuthException(message: e.toString());
    }
  }

  @override
  void storeLoggedInUserInfo(UserModel user) {
    try {
      final expirationDate = DateTime.now().add(const Duration(days: 30));
      _hiveBox.write(() {
        _hiveBox.put("loggedInUser", user.toJson());
        _hiveBox.put("tokenExpires", expirationDate.toIso8601String());
      });
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
}

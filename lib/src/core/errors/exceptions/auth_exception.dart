import 'package:didi/src/core/errors/exceptions/exceptions.dart';

class AuthException extends Exception {
  AuthException({required super.message, super.code});
}

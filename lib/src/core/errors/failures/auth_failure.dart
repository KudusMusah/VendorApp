import 'package:didi/src/core/errors/failures/failure.dart';

class AuthFailure extends Failure {
  AuthFailure({
    required super.message,
    super.errorCode,
  });
}

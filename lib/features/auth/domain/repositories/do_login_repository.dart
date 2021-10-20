import 'package:dartz/dartz.dart';

import 'package:my_app/core/error/failure.dart';
import 'package:my_app/features/auth/domain/usecases/entities/user.dart';

abstract class DoLoginRepository {
  Future<Either<Failure, User>> doLogin({
    required String email, required String password
  });
}

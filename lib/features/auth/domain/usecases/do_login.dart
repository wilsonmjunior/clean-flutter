import 'package:dartz/dartz.dart';

import 'package:my_app/core/error/failure.dart';
import 'package:my_app/core/usecases/usecase.dart';
import 'package:my_app/features/auth/domain/repositories/do_login_repository.dart';

import 'entities/user.dart';

class DoLoginParams {
  final String email;
  final String password;

  DoLoginParams({required this.email, required this.password});
}

class DoLogin extends UseCase<User, DoLoginParams> {
  final DoLoginRepository _repository;

  DoLogin(this._repository);

  @override
  Future<Either<Failure, User>> call(DoLoginParams params) async {
    return await _repository.doLogin(
      email: params.email, 
      password: params.password,
    );
  }
}

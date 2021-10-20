import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/core/error/failure.dart';

import 'package:my_app/features/auth/domain/repositories/do_login_repository.dart';
import 'package:my_app/features/auth/domain/usecases/do_login.dart';
import 'package:my_app/features/auth/domain/usecases/entities/user.dart';

class DoLoginRepositoryMock extends Mock implements DoLoginRepository {}

void main() {
  DoLoginRepository _doLoginRepository = DoLoginRepositoryMock();

  DoLogin _doLogin = DoLogin(_doLoginRepository);

  test('Deve realizar o login', ()  async {
    when(() => _doLoginRepository.doLogin(
      email: 'johndoe@email.com', 
      password: '123456'
    )).thenAnswer((_) async => Right(tUser));

    var result = await _doLogin(
      DoLoginParams(
        email: 'johndoe@email.com', 
        password: '123456',
    ));

    expect(result, isA<Right>());
    expect(result, Right(tUser));
    
    verify(
      () => _doLoginRepository.doLogin(
        email: 'johndoe@email.com',
        password: '123456', 
      ),
    )
    .called(1);
    verifyNoMoreInteractions(_doLoginRepository);
  });


  test('Deve obter um erro de senha errada ao realizar o login', ()  async {
    when(() => _doLoginRepository.doLogin(
      email: 'johndoe@email.com', 
      password: '123456'
    )).thenAnswer((_) async => Left(PasswordWrongFailure()));

    var result = await _doLogin(
      DoLoginParams(
        email: 'johndoe@email.com', 
        password: '123456',
    ));

    expect(result, isA<Left>());
    expect(result, Left(PasswordWrongFailure()));
    
    verify(
      () => _doLoginRepository.doLogin(
        email: 'johndoe@email.com',
        password: '123456', 
      ),
    )
    .called(1);
    verifyNoMoreInteractions(_doLoginRepository);
  });
}

var tUser = User(
  name: 'John Doe', 
  bornDate: DateTime.now(), 
  pictureUrl: 'photo.png', 
  email: 'johndoes@email.com',
);

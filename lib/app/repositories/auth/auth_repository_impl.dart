import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dt_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dt_delivery_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:dt_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dt_delivery_app/app/models/auth_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unAuth().post('auth', data: {
        'email': email,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }

      log('Erro ao logar', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao logar usuario');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unAuth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuario', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuario');
    }
  }
}

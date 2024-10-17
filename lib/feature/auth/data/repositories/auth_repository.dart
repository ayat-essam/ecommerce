import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/exceptions.dart';
import 'package:ecommerce/core/error/failure.dart';

import 'package:injectable/injectable.dart';

import '../data_sources/local/auth_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';

@singleton
class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepository(
    this.remoteDataSource,
    this.localDataSource,
  );

  Future<Either<Failure, UserModel>> register(RegisterRequest request) async {
    try {
      final response = await remoteDataSource.register(request);
      await localDataSource.saveToken(response.token);
      return Right(response.user);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, UserModel>> login(LoginRequest request) async {
    try {
      final response = await remoteDataSource.login(request);
      await localDataSource.saveToken(response.token);
      return Right(response.user);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}

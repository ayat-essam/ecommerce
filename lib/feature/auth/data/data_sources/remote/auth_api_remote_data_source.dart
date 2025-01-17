import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants.dart';
import 'package:ecommerce/core/error/exceptions.dart';
import 'package:ecommerce/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:ecommerce/features/auth/data/models/login_request.dart';
import 'package:ecommerce/features/auth/data/models/login_response.dart';
import 'package:ecommerce/features/auth/data/models/register_request.dart';
import 'package:ecommerce/features/auth/data/models/register_response.dart';
import 'package:injectable/injectable.dart';

import '../../models/login_request.dart';
import '../../models/login_response.dart';
import '../../models/register_request.dart';
import '../../models/register_response.dart';
import 'auth_remote_data_source.dart';

@Singleton(as:AuthRemoteDataSource )
class AuthAPIRemoteDataSource extends AuthRemoteDataSource {
  final Dio dio = Dio(
  BaseOptions(baseUrl: APIConstants.baseURL,
  receiveDataWhenStatusError: true,),
  );

  AuthAPIRemoteDataSource(Dio dio);
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try{
      final response =await dio.post(APIConstants.registerEndpoint,
          data:request.toJson(),);
      return RegisterResponse.fromJson(response.data);
    }catch(expetion){
      String? message;
      if(expetion is  DioException){
        message = expetion.response?.data['message'];
      }throw RemoteException(message ?? 'failed to register');
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest request)async {
   try{
     final response = await dio.post(APIConstants.loginEndpoint,
     data: request.toJson());
     return LoginResponse.fromJson(response.data);
   }catch(exception){
     String? message;
     if(exception is DioException){
       message = exception.response?.data['message'];
     }throw RemoteException(message??'failed to Login');
   }
  }



}

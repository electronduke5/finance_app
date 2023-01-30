import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_app/data/services/api_const_routes.dart';
import 'package:finance_app/data/utils/api_response.dart';
import 'package:finance_app/domain/repositories/auth_repository.dart';

import '../model/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<ApiResponse<String>> refreshToken(String currentToken) async {
    //final dio = Dio(BaseOptions(validateStatus: (status) => true));
    final dio = Dio();
    final response = await dio
        .post("${ApiConstUrl.baseUrl}${ApiConstUrl.tokenUrl}/$currentToken");
    if (response.statusCode != HttpStatus.ok) {
      final message = response.data['message'];
      return ApiResponse(
        data: null,
        hasError: true,
        message: message,
      );
    }
    final user = User.fromJson(response.data['data']);
    return ApiResponse(
      data: user.refreshToken,
      hasError: false,
      message: null,
    );
  }

  @override
  Future<ApiResponse<String>> signIn(String userName, String password) async {
    final dio = Dio();
    final response = await dio.post(
      "${ApiConstUrl.baseUrl}${ApiConstUrl.tokenUrl}",
      data: {
        "userName": userName,
        "password": password,
      },
      options: Options(contentType: "application/json"),
    );
    if (response.statusCode != HttpStatus.ok) {
      final message = response.data["message"];
      return ApiResponse(
        hasError: true,
        data: null,
        message: message,
      );
    }

    final user = User.fromJson(response.data["data"]);
    return ApiResponse(
      hasError: false,
      data: user.refreshToken,
      message: null,
    );
  }

  @override
  Future<ApiResponse<String>> signUp(
      String userName, String password, String email) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => true,
      ),
    );
    final response = await dio.put(
      "${ApiConstUrl.baseUrl}${ApiConstUrl.tokenUrl}",
      data: {
        "email": email,
        "userName": userName,
        "password": password,
      },
      options: Options(contentType: "application/json"),
    );
    if (response.statusCode != HttpStatus.ok) {
      final message = response.data["message"];
      return ApiResponse(
        hasError: true,
        data: null,
        message: message,
      );
    }
    return signIn(userName, password);
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_app/data/model/user.dart';
import 'package:finance_app/data/services/api_const_routes.dart';
import 'package:finance_app/data/utils/api_response.dart';
import 'package:finance_app/domain/repositories/profile_repository.dart';
import 'package:finance_app/presentation/di/app_module.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  @override
  Future<ApiResponse<User>> getProfile() async {
    final token = AppModule.getTokenHolder().apiToken;
    print('token in profile repo: $token');
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );
    final response = await dio.get('${ApiConstUrl.baseUrl}${ApiConstUrl.userUrl}');
    if (response.statusCode != HttpStatus.ok) {
      final message = response.data["message"];
      return ApiResponse(
        hasError: true,
        data: null,
        message: message,
      );
    }
    print(response);
    print(response.data);
    print(response.data['data']);
    final user = User.fromJson(response.data);
    return ApiResponse(
      hasError: false,
      data: user,
      message: null,
    );
  }

}
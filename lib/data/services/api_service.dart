import 'dart:io';

import 'package:dio/dio.dart';

import '../../presentation/di/app_module.dart';
import 'api_const_routes.dart';

mixin ApiService<T>{
  abstract String apiRoute;

  Future<List<T>> get({
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final token = AppModule.getTokenHolder().apiToken;
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );

    final response = await dio.get('${ApiConstUrl.baseUrl}$apiRoute');
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }
    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => fromJson(e)).toList();
  }

}

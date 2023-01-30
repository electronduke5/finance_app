import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_app/data/model/category.dart';
import 'package:finance_app/domain/repositories/category_repository.dart';

import '../../presentation/di/app_module.dart';
import '../services/api_const_routes.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<Category>> getAll() async{
    final token = AppModule.getTokenHolder().apiToken;
    final dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) => true,
      ),
    );
    final response =
        await dio.get("${ApiConstUrl.baseUrl}${ApiConstUrl.categoryUrl}");
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => Category.fromJson(e)).toList();
  }

}
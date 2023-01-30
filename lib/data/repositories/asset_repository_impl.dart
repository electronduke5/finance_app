import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_app/data/model/asset.dart';
import 'package:finance_app/data/services/api_const_routes.dart';
import 'package:finance_app/domain/repositories/asset_repository.dart';

import '../../presentation/di/app_module.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  @override
  Future<List<Asset>> getAll() async {
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
        await dio.get("${ApiConstUrl.baseUrl}${ApiConstUrl.assetUrl}");
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => Asset.fromJson(e)).toList();
  }
}

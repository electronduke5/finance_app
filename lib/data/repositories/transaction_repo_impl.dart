import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finance_app/data/model/transaction.dart';
import 'package:finance_app/domain/repositories/transaction_category.dart';

import '../../presentation/di/app_module.dart';
import '../services/api_const_routes.dart';

class TransactionRepositoryImpl implements TransactionRepository{
  @override
  Future<List<Transaction>> getAll() async {
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
        await dio.get("${ApiConstUrl.baseUrl}${ApiConstUrl.transactionUrl}");
    if (response.statusCode != HttpStatus.ok) {
      return [];
    }

    final jsonList = response.data as List<dynamic>;
    return jsonList.map((e) => Transaction.fromJson(e)).toList();
  }

}
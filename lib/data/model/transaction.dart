import 'package:freezed_annotation/freezed_annotation.dart';

import 'asset.dart';
import 'category.dart';

part '../../domain/model/transaction/transaction.freezed.dart';

part '../../domain/model/transaction/transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required DateTime date,
    required String title,
    required double amount,
    required Category category,
    required Asset asset,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

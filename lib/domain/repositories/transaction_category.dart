import 'package:finance_app/data/model/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAll();
}

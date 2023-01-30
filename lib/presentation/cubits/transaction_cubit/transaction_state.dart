part of 'transaction_cubit.dart';

class TransactionState {
  final ApiStatus<List<Transaction>> status;

  TransactionState({this.status = const IdleStatus()});

  TransactionState copyWith({
    ApiStatus<List<Transaction>>? status,
  }) =>
      TransactionState(
        status: status ?? this.status,
      );
}

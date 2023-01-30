import 'package:bloc/bloc.dart';
import 'package:finance_app/presentation/cubits/models_status.dart';

import '../../../data/model/transaction.dart';
import '../../di/app_module.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionState());

  Future<void> loadTransaction() async {
    final repository = AppModule.getTransactionRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final transactions = await repository.getAll();
      emit(state.copyWith(status: LoadedStatus(transactions)));
    } catch (exception) {
      emit(state.copyWith(status: FailedStatus(exception.toString())));
    }
  }
}

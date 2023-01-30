import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/transaction.dart';
import '../cubits/models_status.dart';
import '../cubits/transaction_cubit/transaction_cubit.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            switch (state.status.runtimeType) {
              case LoadedStatus<List<Transaction>>:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.status.item!.length,
                  itemBuilder: (context, index) {
                    final item = state.status.item![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTransactionWidget(item),
                    );
                  },
                );
              case FailedStatus<List<Transaction>>:
                return Center(
                  child: Text(
                    state.status.message ?? "Неизвестная ошибка",
                  ),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget buildTransactionWidget(Transaction item) {
    return Card(
      child: Column(
        children: [
          Text(
            "Транзакция №${item.id}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "${item.amount} руб.",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            "Счёт '${item.asset.name}'",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            "Категория '${item.category.name}'",
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

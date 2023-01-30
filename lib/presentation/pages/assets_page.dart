import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/asset.dart';
import '../cubits/asset_cubit/asset_cubit.dart';
import '../cubits/models_status.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AssetCubit, AssetState>(
          builder: (context, state) {
            switch (state.assetStatus.runtimeType) {
              case LoadedStatus<List<Asset>>:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.assetStatus.item!.length,
                  itemBuilder: (context, index) {
                    final item = state.assetStatus.item![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildAssetWidget(item),
                    );
                  },
                );
              case FailedStatus<List<Asset>>:
                return Center(
                  child: Text(
                    state.assetStatus.message ?? "Неизвестная ошибка",
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

  Widget buildAssetWidget(Asset item) {
    return Card(
      child: Column(
        children: [
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Баланс: ${item.balance}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            "Тип счета: ${item.type.name}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/category.dart';
import '../cubits/category_cubit/category_cubit.dart';
import '../cubits/models_status.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            switch (state.categoryStatus.runtimeType) {
              case LoadedStatus<List<Category>>:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categoryStatus.item!.length,
                  itemBuilder: (context, index) {
                    final item = state.categoryStatus.item![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildCategoryWidget(item),
                    );
                  },
                );
              case FailedStatus<List<Category>>:
                return Center(
                  child: Text(
                    state.categoryStatus.message ?? "Неизвестная ошибка",
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

  Widget buildCategoryWidget(Category item) {
    return Card(
      child: Column(
        children: [
          Text(
            "Категория №${item.id}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

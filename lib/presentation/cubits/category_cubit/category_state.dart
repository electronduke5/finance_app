part of 'category_cubit.dart';

class CategoryState {
  final ApiStatus<List<Category>> categoryStatus;

  CategoryState({this.categoryStatus = const IdleStatus()});

  CategoryState copyWith({
    ApiStatus<List<Category>>? categoryStatus,
  }) =>
      CategoryState(
        categoryStatus: categoryStatus ?? this.categoryStatus,
      );
}

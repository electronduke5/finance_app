import 'package:bloc/bloc.dart';
import 'package:finance_app/presentation/cubits/models_status.dart';
import 'package:finance_app/data/model/category.dart';

import '../../di/app_module.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState());

  Future<void> loadCategories() async {
    final repository = AppModule.getCategoryRepository();
    emit(state.copyWith(categoryStatus: LoadingStatus()));
    try{
      final categories = await repository.getAll();
      emit(state.copyWith(categoryStatus: LoadedStatus(categories)));
    }catch (exception){
      emit(state.copyWith(categoryStatus: FailedStatus(exception.toString())));
    }
  }
}

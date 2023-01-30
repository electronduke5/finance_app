import '../../data/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll();
}

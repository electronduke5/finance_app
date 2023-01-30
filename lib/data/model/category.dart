import 'package:freezed_annotation/freezed_annotation.dart';

part '../../domain/model/category/category.freezed.dart';

part '../../domain/model/category/category.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    //required User user,
    //required bool isDeleted,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

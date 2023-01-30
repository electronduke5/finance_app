import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part '../../domain/model/history/history.freezed.dart';
part '../../domain/model/history/history.g.dart';
@freezed
class History with _$History {
  const factory History({
    required int id,
    required String tableName,
    required String description,
    required DateTime date,
    required User user,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}
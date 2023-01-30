// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      id: json['id'] as int,
      tableName: json['tableName'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableName': instance.tableName,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'user': instance.user,
    };

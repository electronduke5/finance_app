// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/model/asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Asset _$$_AssetFromJson(Map<String, dynamic> json) => _$_Asset(
      id: json['id'] as int,
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      type: TypeAsset.values
          .firstWhere((element) => element.id == json['type'] as int),
      //type: $enumDecode(_$TypeAssetEnumMap, json['type']),
    );

Map<String, dynamic> _$$_AssetToJson(_$_Asset instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': instance.balance,
      //'type': _$TypeAssetEnumMap[instance.type]!,
      'type': TypeAsset.values.firstWhere((e) => e.id == instance.id),
    };

const _$TypeAssetEnumMap = {
  TypeAsset.cash: 'cash',
  TypeAsset.card: 'card',
};

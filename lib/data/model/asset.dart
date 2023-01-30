import 'package:freezed_annotation/freezed_annotation.dart';

import 'type_asset.dart';

part '../../domain/model/asset/asset.freezed.dart';

part '../../domain/model/asset/asset.g.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    required int id,
    required String name,
    required double balance,
    required TypeAsset type,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

part of 'asset_cubit.dart';

class AssetState {
  final ApiStatus<List<Asset>> assetStatus;

  AssetState({this.assetStatus = const IdleStatus()});

  AssetState copyWith({ApiStatus<List<Asset>>? assetStatus}) => AssetState(
        assetStatus: assetStatus ?? this.assetStatus,
      );
}

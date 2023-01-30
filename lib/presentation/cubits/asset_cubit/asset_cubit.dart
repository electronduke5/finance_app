import 'package:bloc/bloc.dart';
import 'package:finance_app/presentation/cubits/models_status.dart';
import 'package:finance_app/presentation/di/app_module.dart';

import '../../../data/model/asset.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  AssetCubit() : super(AssetState());

  Future<void> loadAssets() async {
    final repository = AppModule.getAssetRepository();
    emit(state.copyWith(assetStatus: LoadingStatus()));
    try {
      final assets = await repository.getAll();
      emit(state.copyWith(assetStatus: LoadedStatus(assets)));
    } catch (exception) {
      emit(state.copyWith(assetStatus: FailedStatus(exception.toString())));
    }
  }
}

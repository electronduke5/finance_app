import '../../data/model/asset.dart';

abstract class AssetsRepository {
  Future<List<Asset>> getAll();
}

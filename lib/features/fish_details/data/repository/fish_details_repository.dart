import 'package:fishing_app/features/fish_details/data/data_source/fish_details_data_source.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

abstract interface class FishDetailsRepository {
  Future<FishEntity> getFishById(int id);
}

class FishDetailsRepositoryImpl implements FishDetailsRepository {
  const FishDetailsRepositoryImpl(this._fishDetailsDataSource);

  final FishDetailsDataSource _fishDetailsDataSource;

  @override
  Future<FishEntity> getFishById(int id) =>
      _fishDetailsDataSource.getFishById(id).then(FishEntity.fromCompanion);
}

import 'package:fishing_app/features/home/data/repository/models/fish.dart';
import 'package:fishing_app/features/sightings/data/data_source/sightings_data_source.dart';

abstract interface class SightingsRepository {
  Stream<List<FishEntity>> watchFishesByLocation(int locationId);
}

class SightingsRepositoryImpl implements SightingsRepository {
  SightingsRepositoryImpl(this._sightingsDataSource);

  final SightingsDataSource _sightingsDataSource;

  @override
  Stream<List<FishEntity>> watchFishesByLocation(int locationId) =>
      _sightingsDataSource
          .watchFishesByLocation(locationId)
          .map((rows) => rows.map(FishEntity.fromCompanion).toList());
}

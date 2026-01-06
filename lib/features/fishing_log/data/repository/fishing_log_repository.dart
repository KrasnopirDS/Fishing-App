import 'package:fishing_app/features/fishing_log/data/data_source/fishing_log_data_source.dart';
import 'package:fishing_app/features/fishing_log/data/repository/models/location.dart';

abstract interface class FishingLogRepository {
  Stream<List<LocationEntity>> watchAllLocations();

  Stream<LocationEntity?> watchLocationById(int id);
}

class FishingLogRepositoryImpl implements FishingLogRepository {
  FishingLogRepositoryImpl(this._fishingLogDataSource);

  final FishingLogDataSource _fishingLogDataSource;

  @override
  Stream<List<LocationEntity>> watchAllLocations() => _fishingLogDataSource
      .watchAllLocations()
      .map((rows) => rows.map(LocationEntity.fromCompanion).toList());

  @override
  Stream<LocationEntity?> watchLocationById(int id) =>
      _fishingLogDataSource.watchLocationById(id).map((row) {
        return row != null ? LocationEntity.fromCompanion(row) : null;
      });
}

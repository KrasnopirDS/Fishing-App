import 'package:fishing_app/core/database/app_database.dart';

abstract interface class SightingsDataSource {
  Stream<List<Fish>> watchFishesByLocation(int locationId);
}

class SightingsDataSourceImpl implements SightingsDataSource {
  SightingsDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Fish>> watchFishesByLocation(int locationId) =>
      _database.watchFishesByLocationId(locationId);
}

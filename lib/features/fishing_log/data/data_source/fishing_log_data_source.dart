import 'package:fishing_app/core/database/app_database.dart';

abstract interface class FishingLogDataSource {
  Stream<List<Location>> watchAllLocations();

  Stream<Location?> watchLocationById(int id);
}

class FishingLogDataSourceImpl implements FishingLogDataSource {
  FishingLogDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Location>> watchAllLocations() => _database.watchAllLocations();

  @override
  Stream<Location?> watchLocationById(int id) =>
      _database.watchLocationById(id);
}

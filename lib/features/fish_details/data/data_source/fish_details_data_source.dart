import 'package:fishing_app/core/database/app_database.dart';

abstract interface class FishDetailsDataSource {
  Future<Fish> getFishById(int id);
}

class FishDetailsDataSourceImpl implements FishDetailsDataSource {
  FishDetailsDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<Fish> getFishById(int id) => _database.getFishById(id);
}

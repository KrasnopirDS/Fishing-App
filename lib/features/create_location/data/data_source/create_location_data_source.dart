import 'package:fishing_app/core/database/app_database.dart';

abstract interface class CreateLocationDataSource {
  Future<int> addLocation(LocationsCompanion entry);
}

class CreateLocationDataSourceImpl implements CreateLocationDataSource {
  CreateLocationDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<int> addLocation(LocationsCompanion entry) =>
      _database.addLocation(entry);
}

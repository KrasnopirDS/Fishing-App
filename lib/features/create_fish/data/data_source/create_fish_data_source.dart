import 'package:fishing_app/core/database/app_database.dart';

abstract interface class CreateFishDataSource {
  Future<int> addFish(FishesCompanion entry);
}

class CreateFishDataSourceImpl implements CreateFishDataSource {
  CreateFishDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<int> addFish(FishesCompanion entry) => _db.addFish(entry);
}

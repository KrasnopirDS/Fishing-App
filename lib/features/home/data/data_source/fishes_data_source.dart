import 'package:fishing_app/core/database/app_database.dart';

abstract interface class FishesDataSource {
  Stream<List<Fish>> watchAllFishes();
}

class FishesDataSourceImpl implements FishesDataSource {
  FishesDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Fish>> watchAllFishes() => _db.watchAllFishes();

}

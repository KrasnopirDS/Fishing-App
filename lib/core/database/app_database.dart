import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fishing_app/core/database/tables/fishes.dart';
import 'package:fishing_app/core/database/tables/locations.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Fishes, Locations])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;


  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
  Stream<List<Fish>> watchAllFishes() {
    return (select(
      fishes,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  Future<Fish> getFishById(int id) =>
      (select(fishes)..where((t) => t.id.equals(id))).getSingle();

  Future<int> addFish(FishesCompanion entry) => into(fishes).insert(entry);

  Stream<List<Fish>> watchFishesByLocationId(int locationId) =>
      (select(fishes)
        ..where((t) => t.locationId.equals(locationId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<Location>> watchAllLocations() {
    return (select(
      locations,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  Future<int> addLocation(LocationsCompanion entry) =>
      into(locations).insert(entry);

  Stream<Location?> watchLocationById(int id) =>
      (select(locations)..where((t) => t.id.equals(id))).watchSingleOrNull();


}

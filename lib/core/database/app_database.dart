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

}

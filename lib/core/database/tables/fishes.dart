import 'package:drift/drift.dart';
import 'package:fishing_app/core/database/tables/locations.dart';

@DataClassName('Fish')
class Fishes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get imageUrl => text()();

  RealColumn get weight => real()();

  RealColumn get length => real()();

  TextColumn get bait => text()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get locationId =>
      integer().references(Locations, #id, onDelete: .cascade)();
}

import 'package:drift/drift.dart';

@DataClassName('Location')
class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get imageUrl => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

}

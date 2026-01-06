import 'package:drift/drift.dart';
import 'package:fishing_app/core/database/app_database.dart';

class LocationEntity {
  const LocationEntity({
    required this.name,
    required this.imageUrl,
    this.date,
    this.id,
  });

  factory LocationEntity.fromCompanion(Location entry) {
    return LocationEntity(
      id: entry.id,
      name: entry.name,
      date: entry.createdAt,
      imageUrl: entry.imageUrl,
    );
  }

  factory LocationEntity.empty() =>
      const LocationEntity(name: '', imageUrl: '');

  final int? id;
  final String name;
  final DateTime? date;
  final String imageUrl;

  LocationsCompanion toCompanion() {
    return LocationsCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      name: name,
      imageUrl: imageUrl,
      createdAt: date != null ? Value(date!) : const Value.absent(),
    );
  }
}

import 'package:drift/drift.dart';
import 'package:fishing_app/core/database/app_database.dart';

class FishEntity {
  const FishEntity({
    required this.bait,
    required this.name,
    required this.imageUrl,
    required this.weight,
    required this.length,
    this.createdAt,
    this.notes,
    this.id,
    this.locationId,
  });

  factory FishEntity.fromCompanion(Fish entry) {
    return FishEntity(
      id: entry.id,
      name: entry.name,
      imageUrl: entry.imageUrl,
      weight: entry.weight,
      length: entry.length,
      bait: entry.bait,
      notes: entry.notes,
      createdAt: entry.createdAt,
      locationId: entry.locationId,
    );
  }

  final int? id;
  final String name;
  final String imageUrl;
  final double weight;
  final double length;
  final String bait;
  final String? notes;
  final DateTime? createdAt;
  final int? locationId;

  FishesCompanion toCompanion() {
    return FishesCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      name: name,
      imageUrl: imageUrl,
      weight: weight,
      length: length,
      bait: bait,
      notes: notes != null ? Value(notes) : const Value.absent(),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      locationId: locationId!,
    );
  }


}

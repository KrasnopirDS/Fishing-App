

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

  final int? id;
  final String name;
  final String imageUrl;
  final double weight;
  final double length;
  final String bait;
  final String? notes;
  final DateTime? createdAt;
  final int? locationId;


}

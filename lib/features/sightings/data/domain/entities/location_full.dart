import 'package:fishing_app/features/fishing_log/data/repository/models/location.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

class LocationFull {
  const LocationFull({required this.location, required this.fishes});

  factory LocationFull.empty() =>
      LocationFull(location: LocationEntity.empty(), fishes: []);

  final LocationEntity location;
  final List<FishEntity> fishes;
}

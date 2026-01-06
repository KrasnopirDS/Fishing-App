import 'package:fishing_app/features/fishing_log/data/repository/fishing_log_repository.dart';
import 'package:fishing_app/features/sightings/data/domain/entities/location_full.dart';
import 'package:fishing_app/features/sightings/data/repository/sightings_repository.dart';
import 'package:rxdart/rxdart.dart';

class SightingsUseCase {
  SightingsUseCase({
    required this.fishingLogRepository,
    required this.sightingsRepository,
  });

  final FishingLogRepository fishingLogRepository;
  final SightingsRepository sightingsRepository;

  Stream<LocationFull?> call(int locationId) {
    final location = fishingLogRepository.watchLocationById(locationId);
    final fishes = sightingsRepository.watchFishesByLocation(locationId);

    return Rx.combineLatest2(location, fishes, (location, fishes) {
      final locationFull = location == null
          ? null
          : LocationFull(location: location, fishes: fishes);
      return locationFull;
    });
  }
}

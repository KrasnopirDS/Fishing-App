import 'package:equatable/equatable.dart';
import 'package:fishing_app/features/sightings/data/domain/entities/location_full.dart';

sealed class SightingsState extends Equatable {
  const SightingsState();

  @override
  List<Object> get props => [];
}

final class SightingsInitial extends SightingsState {}

final class SightingsLoading extends SightingsState {}

final class SightingsEmpty extends SightingsState {}

final class SightingsLoaded extends SightingsState {
  const SightingsLoaded(this.fishes);

  final LocationFull fishes;

  @override
  List<Object> get props => [fishes];
}

final class SightingsError extends SightingsState {
  const SightingsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:fishing_app/features/fishing_log/data/repository/models/location.dart';

sealed class FishingLogState extends Equatable {
  const FishingLogState();

  @override
  List<Object> get props => [];
}

final class FishingLogInitial extends FishingLogState {}

final class FishingLogLoading extends FishingLogState {}

final class FishingLogLoaded extends FishingLogState {
  const FishingLogLoaded(this.locations);

  final List<LocationEntity> locations;

  @override
  List<Object> get props => [locations];
}

final class FishingLogError extends FishingLogState {
  const FishingLogError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

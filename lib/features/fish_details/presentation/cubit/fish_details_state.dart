import 'package:equatable/equatable.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

sealed class FishDetailsState extends Equatable {
  const FishDetailsState();

  @override
  List<Object> get props => [];
}

final class FishDetailsInitial extends FishDetailsState {}

final class FishDetailsLoading extends FishDetailsState {}

final class FishDetailsLoaded extends FishDetailsState {
  const FishDetailsLoaded(this.fish);

  final FishEntity fish;

  @override
  List<Object> get props => [fish];
}

final class FishDetailsError extends FishDetailsState {
  const FishDetailsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

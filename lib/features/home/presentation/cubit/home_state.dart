import 'package:equatable/equatable.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded(this.fishes);

  final List<FishEntity> fishes;

  @override
  List<Object> get props => [fishes];
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

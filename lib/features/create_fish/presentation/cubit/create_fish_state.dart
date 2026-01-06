import 'package:equatable/equatable.dart';

enum CreateFishStatus { initial, loading, success, error }

class CreateFishState extends Equatable {
  const CreateFishState({
    this.name = '',
    this.imageUrl,
    this.weight = 0.0,
    this.length = 0.0,
    this.bait = '',
    this.notes,
    this.locationId = 0,
    this.status = CreateFishStatus.initial,
    this.error,
  });

  final String name;
  final String? imageUrl;
  final double weight;
  final double length;
  final String bait;
  final String? notes;
  final int locationId;
  final CreateFishStatus status;
  final String? error;

  CreateFishState copyWith({
    String? name,
    String? imageUrl,
    double? weight,
    double? length,
    String? bait,
    String? notes,
    int? locationId,
    CreateFishStatus? status,
    String? error,
  }) {
    return CreateFishState(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      weight: weight ?? this.weight,
      length: length ?? this.length,
      bait: bait ?? this.bait,
      notes: notes ?? this.notes,
      locationId: locationId ?? this.locationId,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    name,
    imageUrl,
    weight,
    length,
    bait,
    notes,
    locationId,
    status,
    error,
  ];
}

import 'package:equatable/equatable.dart';

enum CreateLocationStatus { initial, loading, success, error }

class CreateLocationState extends Equatable {
  const CreateLocationState({
    this.name = '',
    this.imageUrl,
    this.error,
    this.status = CreateLocationStatus.initial,
  });

  final String name;
  final String? imageUrl;
  final CreateLocationStatus status;
  final String? error;

  CreateLocationState copyWith({
    String? name,
    String? imageUrl,
    CreateLocationStatus? status,
    String? error,
  }) {
    return CreateLocationState(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [name, imageUrl, status, error];
}

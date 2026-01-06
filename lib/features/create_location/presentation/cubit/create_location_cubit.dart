import 'package:fishing_app/features/create_location/data/repository/create_location_repository.dart';
import 'package:fishing_app/features/create_location/presentation/cubit/create_location_state.dart';
import 'package:fishing_app/features/fishing_log/data/repository/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateLocationCubit extends Cubit<CreateLocationState> {
  CreateLocationCubit(this._createLocationRepository)
      : super(const CreateLocationState());

  final CreateLocationRepository _createLocationRepository;

  void nameChanged(String name) {
    emit(state.copyWith(name: name, status: .initial));
  }

  void imageUrlChanged(String imageUrl) {
    emit(state.copyWith(imageUrl: imageUrl, status: .initial));
  }

  Future<void> addLocation() async {
    emit(state.copyWith(status: .loading));
    try {
      final location = LocationEntity(
        name: state.name,
        imageUrl: state.imageUrl!,
      );
      await _createLocationRepository.addLocation(location);
      emit(state.copyWith(status: .success));
    } catch (e) {
      emit(state.copyWith(status: .error, error: e.toString()));
    }
  }
}

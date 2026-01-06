import 'package:fishing_app/features/create_fish/data/repository/create_fish_repository.dart';
import 'package:fishing_app/features/create_fish/presentation/cubit/create_fish_state.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFishCubit extends Cubit<CreateFishState> {
  CreateFishCubit(this._createFishRepository) : super(const CreateFishState());

  final CreateFishRepository _createFishRepository;

  void nameChanged(String name) {
    emit(state.copyWith(name: name, status: .initial));
  }

  void imageUrlChanged(String imageUrl) {
    emit(state.copyWith(imageUrl: imageUrl, status: .initial));
  }

  void weightChanged(String weight) {
    emit(
      state.copyWith(weight: double.tryParse(weight) ?? 0.0, status: .initial),
    );
  }

  void lengthChanged(String length) {
    emit(
      state.copyWith(length: double.tryParse(length) ?? 0.0, status: .initial),
    );
  }

  void baitChanged(String bait) {
    emit(state.copyWith(bait: bait, status: .initial));
  }

  void notesChanged(String notes) {
    emit(state.copyWith(notes: notes, status: .initial));
  }

  void locationIdChanged(int locationId) {
    emit(state.copyWith(locationId: locationId, status: .initial));
  }

  Future<void> addFish() async {
    emit(state.copyWith(status: .loading));

    try {
      final fish = FishEntity(
        bait: state.bait,
        name: state.name,
        imageUrl: state.imageUrl!,
        weight: state.weight,
        length: state.length,
        notes: state.notes,
        locationId: state.locationId,
      );
      await _createFishRepository.addFish(fish);
      emit(state.copyWith(status: .success));
    } catch (e) {
      emit(state.copyWith(status: .error, error: e.toString()));
    }
  }
}

import 'package:fishing_app/features/fish_details/data/repository/fish_details_repository.dart';
import 'package:fishing_app/features/fish_details/presentation/cubit/fish_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FishDetailsCubit extends Cubit<FishDetailsState> {
  FishDetailsCubit(this._fishDetailsRepository) : super(FishDetailsInitial());

  final FishDetailsRepository _fishDetailsRepository;

  Future<void> loadFish(int fishId) async {
    emit(FishDetailsLoading());
    try {
      final fish = await _fishDetailsRepository.getFishById(fishId);
      emit(FishDetailsLoaded(fish));
    } catch (e) {
      emit(FishDetailsError(e.toString()));
    }
  }
}

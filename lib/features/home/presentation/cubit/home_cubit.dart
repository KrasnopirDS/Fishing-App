import 'dart:async';

import 'package:fishing_app/features/home/data/repository/fishes_repository.dart';
import 'package:fishing_app/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._fishesRepository) : super(HomeInitial());

  final FishesRepository _fishesRepository;

  StreamSubscription<void>? _fishesSubscription;

  Future<void> loadFishes() async {
    emit(HomeLoading());

    await _fishesSubscription?.cancel();

    _fishesSubscription = _fishesRepository.watchAllFishes().listen(
          (fishes) => emit(HomeLoaded(fishes)),
      onError: (Object error) => emit(HomeError(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _fishesSubscription?.cancel();
    return super.close();
  }
}

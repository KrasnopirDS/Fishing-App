import 'dart:async';

import 'package:fishing_app/features/sightings/data/domain/entities/location_full.dart';
import 'package:fishing_app/features/sightings/data/domain/use_cases/sightings_use_case.dart';
import 'package:fishing_app/features/sightings/presentation/cubit/sightings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SightingsCubit extends Cubit<SightingsState> {
  SightingsCubit(this._sightingsUseCase) : super(SightingsInitial());

  late final SightingsUseCase _sightingsUseCase;

  StreamSubscription<LocationFull?>? _sightingsSubscription;

  Future<void> loadFishesByLocation(int locationId) async {
    await _sightingsSubscription?.cancel();
    emit(SightingsLoading());
    try {
      _sightingsSubscription = _sightingsUseCase.call(locationId).listen((
          data,
          ) {
        if (data == null) {
          emit(const SightingsError('Location not found'));
          return;
        }
        if (data.fishes.isEmpty) {
          emit(SightingsEmpty());
        } else {
          emit(SightingsLoaded(data));
        }
      }, onError: (Object error) => emit(SightingsError(error.toString())));
    } catch (e) {
      emit(SightingsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sightingsSubscription?.cancel();
    return super.close();
  }
}

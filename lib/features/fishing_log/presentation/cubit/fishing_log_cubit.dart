import 'dart:async';

import 'package:fishing_app/features/fishing_log/data/repository/fishing_log_repository.dart';
import 'package:fishing_app/features/fishing_log/presentation/cubit/fishing_log_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FishingLogCubit extends Cubit<FishingLogState> {
  FishingLogCubit(this._fishingLogRepository) : super(FishingLogInitial());

  final FishingLogRepository _fishingLogRepository;

  StreamSubscription<void>? _fishingLogSubscription;

  Future<void> loadFishingLog() async {
    emit(FishingLogLoading());

    await _fishingLogSubscription?.cancel();

    _fishingLogSubscription = _fishingLogRepository.watchAllLocations().listen(
          (locations) => emit(FishingLogLoaded(locations)),
      onError: (Object error) => emit(FishingLogError(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _fishingLogSubscription?.cancel();
    return super.close();
  }
}

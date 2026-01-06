import 'package:fishing_app/features/home/data/data_source/fishes_data_source.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

abstract interface class FishesRepository {
  Stream<List<FishEntity>> watchAllFishes();
}

class FishesRepositoryImpl implements FishesRepository {
  FishesRepositoryImpl(this._fishesDataSource);

  final FishesDataSource _fishesDataSource;

  @override
  Stream<List<FishEntity>> watchAllFishes() async* {
    yield* _fishesDataSource.watchAllFishes().map(
          (rows) => rows.map(FishEntity.fromCompanion).toList(),
    );
  }
}

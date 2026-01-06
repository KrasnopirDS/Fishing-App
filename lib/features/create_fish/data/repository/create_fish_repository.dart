import 'package:fishing_app/features/create_fish/data/data_source/create_fish_data_source.dart';
import 'package:fishing_app/features/home/data/repository/models/fish.dart';

abstract interface class CreateFishRepository {
  Future<int> addFish(FishEntity entry);
}

class CreateFishRepositoryImpl implements CreateFishRepository {
  CreateFishRepositoryImpl(this._createFishDataSource);

  final CreateFishDataSource _createFishDataSource;

  @override
  Future<int> addFish(FishEntity entry) async {
    return _createFishDataSource.addFish(entry.toCompanion());
  }
}

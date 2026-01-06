import 'package:fishing_app/features/create_location/data/data_source/create_location_data_source.dart';
import 'package:fishing_app/features/fishing_log/data/repository/models/location.dart';

abstract interface class CreateLocationRepository {
  Future<int> addLocation(LocationEntity entry);
}

class CreateLocationRepositoryImpl implements CreateLocationRepository {
  CreateLocationRepositoryImpl(this._createLocationDataSource);

  final CreateLocationDataSource _createLocationDataSource;

  @override
  Future<int> addLocation(LocationEntity entry) =>
      _createLocationDataSource.addLocation(entry.toCompanion());
}

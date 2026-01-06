import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/create_fish/data/data_source/create_fish_data_source.dart';
import 'package:fishing_app/features/create_fish/data/repository/create_fish_repository.dart';
import 'package:fishing_app/features/create_fish/presentation/cubit/create_fish_cubit.dart';
import 'package:fishing_app/features/create_location/data/data_source/create_location_data_source.dart';
import 'package:fishing_app/features/create_location/data/repository/create_location_repository.dart';
import 'package:fishing_app/features/create_location/presentation/cubit/create_location_cubit.dart';
import 'package:fishing_app/features/fish_details/data/data_source/fish_details_data_source.dart';
import 'package:fishing_app/features/fish_details/data/repository/fish_details_repository.dart';
import 'package:fishing_app/features/fish_details/presentation/cubit/fish_details_cubit.dart';
import 'package:fishing_app/features/fishing_log/data/data_source/fishing_log_data_source.dart';
import 'package:fishing_app/features/fishing_log/data/repository/fishing_log_repository.dart';
import 'package:fishing_app/features/fishing_log/presentation/cubit/fishing_log_cubit.dart';
import 'package:fishing_app/features/home/data/data_source/fishes_data_source.dart';
import 'package:fishing_app/features/home/data/repository/fishes_repository.dart';
import 'package:fishing_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:fishing_app/features/sightings/data/data_source/sightings_data_source.dart';
import 'package:fishing_app/features/sightings/data/domain/use_cases/sightings_use_case.dart';
import 'package:fishing_app/features/sightings/data/repository/sightings_repository.dart';
import 'package:fishing_app/features/sightings/presentation/cubit/sightings_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerSingleton<AppDatabase>(AppDatabase())
    ..registerLazySingleton<FishesDataSource>(
          () => FishesDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<FishesRepository>(
          () => FishesRepositoryImpl(getIt<FishesDataSource>()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt<FishesRepository>()))
    ..registerLazySingleton<FishingLogDataSource>(
          () => FishingLogDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<FishingLogRepository>(
          () => FishingLogRepositoryImpl(getIt<FishingLogDataSource>()),
    )
    ..registerFactory<FishingLogCubit>(
          () => FishingLogCubit(getIt<FishingLogRepository>()),
    )
    ..registerLazySingleton<CreateLocationDataSource>(
          () => CreateLocationDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<CreateLocationRepository>(
          () => CreateLocationRepositoryImpl(getIt<CreateLocationDataSource>()),
    )
    ..registerFactory<CreateLocationCubit>(
          () => CreateLocationCubit(getIt<CreateLocationRepository>()),
    )
    ..registerLazySingleton<CreateFishDataSource>(
          () => CreateFishDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<CreateFishRepository>(
          () => CreateFishRepositoryImpl(getIt<CreateFishDataSource>()),
    )
    ..registerFactory<CreateFishCubit>(
          () => CreateFishCubit(getIt<CreateFishRepository>()),
    )
    ..registerLazySingleton<SightingsDataSource>(
          () => SightingsDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<SightingsRepository>(
          () => SightingsRepositoryImpl(getIt<SightingsDataSource>()),
    )
    ..registerLazySingleton<SightingsUseCase>(
          () => SightingsUseCase(
        fishingLogRepository: getIt<FishingLogRepository>(),
        sightingsRepository: getIt<SightingsRepository>(),
      ),
    )
    ..registerFactory<SightingsCubit>(
          () => SightingsCubit(getIt<SightingsUseCase>()),
    )
    ..registerLazySingleton<FishDetailsDataSource>(
          () => FishDetailsDataSourceImpl(getIt<AppDatabase>()),
    )
    ..registerLazySingleton<FishDetailsRepository>(
          () => FishDetailsRepositoryImpl(getIt<FishDetailsDataSource>()),
    )
    ..registerFactory<FishDetailsCubit>(
          () => FishDetailsCubit(getIt<FishDetailsRepository>()),
    );
}

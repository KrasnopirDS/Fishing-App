import 'package:fishing_app/di/get_it.dart';
import 'package:fishing_app/features/app/presentation/ui/screens/welcome_screen.dart';
import 'package:fishing_app/features/create_fish/presentation/ui/screens/create_fish_screen.dart';
import 'package:fishing_app/features/create_location/presentation/ui/screens/create_location_screen.dart';
import 'package:fishing_app/features/fish_details/presentation/cubit/fish_details_cubit.dart';
import 'package:fishing_app/features/fish_details/presentation/ui/screens/fish_details_screen.dart';
import 'package:fishing_app/features/fishing_log/presentation/ui/screens/fishing_log_screen.dart';
import 'package:fishing_app/features/home/presentation/ui/screens/home_screen.dart';
import 'package:fishing_app/features/sightings/presentation/cubit/sightings_cubit.dart';
import 'package:fishing_app/features/sightings/presentation/ui/screens/sightings_screen.dart';
import 'package:fishing_app/router/screen_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/home',
      name: ScreenNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/fish-details/:fishId',
      name: ScreenNames.fishDetails,
      builder: (context, state) {
        final fishId = int.tryParse(state.pathParameters['fishId'] ?? '') ?? 0;
        return BlocProvider(
          create: (context) => getIt<FishDetailsCubit>()..loadFish(fishId),
          child: FishDetailsScreen(fishId: fishId),
        );
      },
    ),
    GoRoute(
      path: '/fishing-log',
      name: ScreenNames.fishingLog,
      builder: (context, state) => const FishingLogScreen(),
      routes: [
        GoRoute(
          path: 'create-location',
          name: ScreenNames.createLocation,
          builder: (context, state) => const CreateLocationScreen(),
        ),
        GoRoute(
          path: 'sightings/:locationId',
          name: ScreenNames.sightings,
          builder: (context, state) {
            final locationId =
                int.tryParse(state.pathParameters['locationId'] ?? '') ?? 0;
            return BlocProvider(
              create: (context) =>
              getIt<SightingsCubit>()..loadFishesByLocation(locationId),
              child: SightingsScreen(locationId: locationId),
            );
          },
        ),
        GoRoute(
          path: 'create-fish/:locationId',
          name: ScreenNames.createFish,
          builder: (context, state) => CreateFishScreen(
            locationId:
            int.tryParse(state.pathParameters['locationId'] ?? '') ?? 0,
          ),
        ),
      ],
    ),
  ],
);

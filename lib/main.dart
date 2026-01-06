import 'package:fishing_app/di/get_it.dart';
import 'package:fishing_app/features/fishing_log/presentation/cubit/fishing_log_cubit.dart';
import 'package:fishing_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:fishing_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..loadFishes()),
        BlocProvider(
          create: (context) => getIt<FishingLogCubit>()..loadFishingLog(),
        ),
      ],
      child: MaterialApp.router(title: 'Flutter Demo', routerConfig: router),
    );
  }
}

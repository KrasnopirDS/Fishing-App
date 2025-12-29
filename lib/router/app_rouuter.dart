import 'package:fishing_app/features/app/presentation/ui/screens/welcome_screen.dart';
import 'package:fishing_app/features/home/presentation/ui/screens/home_screen.dart';
import 'package:fishing_app/router/screen_names.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/home',
      name: ScreenNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

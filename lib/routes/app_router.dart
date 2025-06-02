import 'package:beyond/features/auth/presentation/splash/view/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_routes/simple_routes.dart';

part 'splash_route.dart';

final router = GoRouter(
  initialLocation: SplashRoute().fullPath(),
  routes: [GoRoute(path: SplashRoute().path, builder: (_, state) => SplashPage())],
);

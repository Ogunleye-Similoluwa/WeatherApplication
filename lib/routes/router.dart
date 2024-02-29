import 'package:go_router/go_router.dart';

import 'package:weathercommuteapplication/screens/homepage.dart';
import 'package:weathercommuteapplication/screens/weatherInfo.dart';

import '../screens/splashScreen.dart';

class RouteConfig {
  static GoRouter router = GoRouter(
      initialLocation: "/splash_screen",

      routes: [
        GoRoute(
          name: "home",
          path: "/home",
          builder: (context, state) => Homepage(),
        ),
        GoRoute(
          name: "splash_screen",
          path: "/splash_screen",
          builder: (context, state) => SplashScreen(),
        ),

        GoRoute(
          name: "info",
          path: "/info",
          builder: (context, state) => WeatherDetailsScreen(),
        )

      ]
  );
}
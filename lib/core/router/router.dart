import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/routes.dart';

final routerKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      navigatorKey: routerKey,
      initialLocation: HomeRoute().location,
      routes: $appRoutes,
      redirect: (context, state) {
        debugPrint('*** REDIRECT: ${state.uri.path} ***');

        return null;
      },
    );
  }
}

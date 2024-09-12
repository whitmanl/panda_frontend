// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:panda_frontend/events/create_edit_details_screen.dart';
import 'package:panda_frontend/events/event_details_screen.dart';
import 'package:panda_frontend/events/events_screen.dart';

// Project imports:

import 'package:panda_frontend/splash/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: '/event-details',
      builder: (context, state) => EventDetailsScreen(
        id: state.uri.queryParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: '/create-edit-details',
      builder: (context, state) => const CreateEditDetailsScreen(),
    ),
  ],
);

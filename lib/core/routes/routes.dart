import 'package:flutter/material.dart';
import 'package:futmatch_frontend/core/widgets/main_navbar.dart';

import '../../features/app_context/ui/screens/splash_screen.dart';
import '../../features/app_context/ui/screens/league_selection_screen.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/leagues/ui/screens/create_league_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/home': (context) => const MainNavbar(),
  '/league-selection': (context) => const LeagueSelectionScreen(),
  '/create-league': (context) => const CreateLeagueScreen(),
};

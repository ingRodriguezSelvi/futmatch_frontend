import 'package:flutter/material.dart';
import 'package:futmatch_frontend/core/widgets/main_navbar.dart';

import '../../features/auth/ui/screens/login_screen.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginScreen(),
  '/home': (context) => MainNavbar(),
};
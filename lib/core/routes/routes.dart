import 'package:flutter/material.dart';

import '../../features/auth/ui/screens/login_screen.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginScreen(),
};
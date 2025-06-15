import 'package:flutter/material.dart';
import 'package:futmatch_frontend/features/matches/ui/matches_screen.dart';

import '../../features/home/ui/screens/home_screen.dart';



class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key});

  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MatchesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco total
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Fondo blanco del navbar
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue, // Ítem activo (círculo azul)
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_outlined),
            activeIcon: Icon(Icons.sports_soccer),
            label: 'Partidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            activeIcon:Icon(Icons.fact_check),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.person_outline),
            activeIcon:Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

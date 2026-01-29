import 'package:flutter/material.dart';
import 'package:workout/screens/workout/programs_screen.dart';
import 'package:workout/screens/workout/sessions_screen.dart';
import 'package:workout/screens/nutrition/nutrition_screen.dart';
import 'package:workout/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _pages = const [
    ProgramsScreen(),
    SessionsScreen(),
    NutritionScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          elevation: 0,
          backgroundColor: const Color(0xFF1A1A1A),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Program',
            ),
            NavigationDestination(
              icon: Icon(Icons.timer_outlined),
              selectedIcon: Icon(Icons.timer),
              label: 'Sesi',
            ),
            NavigationDestination(
              icon: Icon(Icons.restaurant_outlined),
              selectedIcon: Icon(Icons.restaurant),
              label: 'Nutrisi',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          onDestinationSelected: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}

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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Programs'),
          NavigationDestination(icon: Icon(Icons.timer), label: 'Sessions'),
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Nutrition'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}

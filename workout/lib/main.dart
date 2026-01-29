import 'package:flutter/material.dart';
import 'package:workout/screens/splash_screen.dart';
import 'package:workout/screens/auth/login_screen.dart';
import 'package:workout/screens/home/home_screen.dart';
import 'package:workout/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.initialize();
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workout/screens/splash_screen.dart';
import 'package:workout/screens/auth/login_screen.dart';
import 'package:workout/screens/home/home_screen.dart';
import 'package:workout/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NotificationService.instance.initialize();
  } catch (e) {
    // Notification service initialization failed, but continue app execution
    debugPrint('Failed to initialize notifications: $e');
  }
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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

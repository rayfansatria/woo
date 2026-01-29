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
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}

ThemeData _buildTheme() {
  const seedColor = Color(0xFF3B82F6); // Professional blue
  
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      surface: Color(0xFF1A1A1A),
      primary: Color(0xFF3B82F6),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F0F0F),
    // App Bar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF1A1A1A),
      foregroundColor: Colors.white,
    ),
    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
    ),
    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
    ),
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: const Color(0xFF3B82F6),
        side: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    // Bottom Navigation
    navigationBarTheme: NavigationBarThemeData(
      elevation: 8,
      backgroundColor: const Color(0xFF1A1A1A),
      indicatorColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ),
    // Text Themes
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFE5E7EB)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF9CA3AF)),
    ),
  );
}

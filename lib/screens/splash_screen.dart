import 'package:flutter/material.dart';
import 'package:workout/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      final loggedIn = await AuthService.instance.isLoggedIn();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, loggedIn ? '/home' : '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 96, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 24),
            Text('Workout', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            const CircularProgressIndicator(),
            const SizedBox(height: 8),
            const Text('Memuat...')
          ],
        ),
      ),
    );
  }
}

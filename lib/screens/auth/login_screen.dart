import 'package:flutter/material.dart';
import 'package:workout/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _doLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final ok = await AuthService.instance.login(_emailCtrl.text.trim(), _passCtrl.text);
    setState(() => _loading = false);
    if (ok && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = 'Email atau password tidak valid.');
    }
  }

  Future<void> _doRegister() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final ok = await AuthService.instance.register(_emailCtrl.text.trim(), _passCtrl.text);
    setState(() => _loading = false);
    if (ok && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = 'Registrasi gagal.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _doLogin,
                    child: _loading ? const CircularProgressIndicator() : const Text('Login'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _loading ? null : _doRegister,
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

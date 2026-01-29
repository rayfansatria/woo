import 'package:flutter/material.dart';
import 'package:workout/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  String? _error;
  late TabController _tabController;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Workout',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mulai perjalanan fitnesmu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: const Color(0xFF1E40AF),
                          unselectedLabelColor: const Color(0xFF9CA3AF),
                          indicatorColor: const Color(0xFF1E40AF),
                          indicatorWeight: 3,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: 'Masuk'),
                            Tab(text: 'Daftar'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Login Tab
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Email Field
                                    TextField(
                                      controller: _emailCtrl,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: const Icon(Icons.email_outlined),
                                        prefixIconColor: const Color(0xFF1E40AF),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    // Password Field
                                    TextField(
                                      controller: _passCtrl,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(Icons.lock_outlined),
                                        prefixIconColor: const Color(0xFF1E40AF),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _showPassword ? Icons.visibility_off : Icons.visibility,
                                          ),
                                          onPressed: () => setState(() => _showPassword = !_showPassword),
                                        ),
                                      ),
                                      obscureText: !_showPassword,
                                    ),
                                    const SizedBox(height: 12),
                                    // Error Message
                                    if (_error != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                                        ),
                                        child: Text(
                                          _error!,
                                          style: const TextStyle(color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    const SizedBox(height: 24),
                                    // Login Button
                                    ElevatedButton(
                                      onPressed: _loading ? null : _doLogin,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        backgroundColor: const Color(0xFF1E40AF),
                                      ),
                                      child: _loading
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  Colors.white.withValues(alpha: 0.8),
                                                ),
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'Masuk',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Register Tab
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Email Field
                                    TextField(
                                      controller: _emailCtrl,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: const Icon(Icons.email_outlined),
                                        prefixIconColor: const Color(0xFF1E40AF),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 16),
                                    // Password Field
                                    TextField(
                                      controller: _passCtrl,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(Icons.lock_outlined),
                                        prefixIconColor: const Color(0xFF1E40AF),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _showPassword ? Icons.visibility_off : Icons.visibility,
                                          ),
                                          onPressed: () => setState(() => _showPassword = !_showPassword),
                                        ),
                                      ),
                                      obscureText: !_showPassword,
                                    ),
                                    const SizedBox(height: 12),
                                    // Error Message
                                    if (_error != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                                        ),
                                        child: Text(
                                          _error!,
                                          style: const TextStyle(color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    const SizedBox(height: 24),
                                    // Register Button
                                    ElevatedButton(
                                      onPressed: _loading ? null : _doRegister,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        backgroundColor: const Color(0xFF1E40AF),
                                      ),
                                      child: _loading
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  const Color.fromARGB(255, 104, 104, 104).withValues(alpha: 0.8),
                                                ),
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'Daftar',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

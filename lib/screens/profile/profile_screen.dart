import 'package:flutter/material.dart';
import 'package:workout/services/auth_service.dart';
import 'package:workout/services/notification_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final email = await AuthService.instance.currentEmail();
    setState(() => _email = email ?? 'Pengguna');
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(context: context, initialTime: _time);
    if (res != null) setState(() => _time = res);
  }

  Future<void> _scheduleReminder() async {
    await NotificationService.instance.scheduleDailyReminder(
      hour: _time.hour,
      minute: _time.minute,
      title: 'Waktunya Workout!',
      body: 'Jadwalkan sesi latihanmu sekarang.',
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder harian disetel')),
    );
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              (_email != null && _email!.isNotEmpty ? _email![0] : 'U').toUpperCase()
            ),
          ),
          const SizedBox(height: 12),
          Center(child: Text(_email ?? 'Pengguna', style: t.textTheme.titleMedium)),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Reminder Harian'),
            subtitle: Text('Jam: ${_time.format(context)}'),
            trailing: TextButton(onPressed: _pickTime, child: const Text('Ubah')),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.schedule),
            label: const Text('Setel Reminder'),
            onPressed: _scheduleReminder,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            onPressed: _logout,
          ),
        ],
      ),
    );
  }
}

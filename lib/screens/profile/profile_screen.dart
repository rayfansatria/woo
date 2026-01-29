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
      SnackBar(
        content: const Text('✓ Reminder harian disetel'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (_email != null && _email!.isNotEmpty ? _email![0] : 'U')
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _email ?? 'Pengguna',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, size: 14, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Member Aktif',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('24', 'Hari Streak', Icons.local_fire_department,
                    const Color(0xFFF59E0B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                    '156', 'Total Sesi', Icons.fitness_center, const Color(0xFF10B981)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                    '2.5k', 'Kalori Burn', Icons.whatshot, const Color(0xFFEF4444)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('12', 'Program', Icons.emoji_events, const Color(0xFF8B5CF6)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Settings Section
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          
          // Reminder Card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_active,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  title: const Text(
                    'Reminder Harian',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Diatur pada ${_time.format(context)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    color: const Color(0xFF3B82F6),
                    onPressed: _pickTime,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _scheduleReminder,
                      icon: const Icon(Icons.schedule, size: 18),
                      label: const Text('Setel Reminder'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Other Settings
          _buildSettingItem(
            Icons.account_circle_outlined,
            'Edit Profil',
            'Ubah nama, foto, dan info lainnya',
            () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            Icons.bar_chart,
            'Statistik',
            'Lihat progress dan pencapaianmu',
            () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            Icons.help_outline,
            'Bantuan & Dukungan',
            'FAQ, Tutorial, dan Kontak',
            () {},
          ),
          const SizedBox(height: 24),
          
          // Logout Button
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Color(0xFFEF4444),
                ),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
              subtitle: const Text(
                'Keluar dari akun',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              onTap: _logout,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF6B7280).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF9CA3AF),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.white.withValues(alpha: 0.4),
        ),
        onTap: onTap,
      ),
    );
  }
}

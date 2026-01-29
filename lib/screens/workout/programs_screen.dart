import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = [
      {
        'title': 'Beginner Full Body',
        'weeks': 4,
        'difficulty': 'Pemula',
        'exercises': 12,
        'icon': Icons.accessibility_new,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Strength Split',
        'weeks': 6,
        'difficulty': 'Menengah',
        'exercises': 18,
        'icon': Icons.fitness_center,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'HIIT Burn',
        'weeks': 4,
        'difficulty': 'Mahir',
        'exercises': 15,
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'Muscle Building',
        'weeks': 8,
        'difficulty': 'Menengah',
        'exercises': 20,
        'icon': Icons.sports_gymnastics,
        'color': const Color(0xFF8B5CF6),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Program Latihan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Stats
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Program Aktif',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Strength Split',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatChip('Minggu 2/6', Icons.calendar_today),
                    const SizedBox(width: 12),
                    _buildStatChip('75% Selesai', Icons.trending_up),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Section Title
          const Text(
            'Semua Program',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          
          // Programs Grid
          ...programs.map((p) => _buildProgramCard(context, p)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF3B82F6),
        icon: const Icon(Icons.add),
        label: const Text('Buat Program'),
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(BuildContext context, Map<String, dynamic> program) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: (program['color'] as Color).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  program['icon'] as IconData,
                  color: program['color'] as Color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildInfoChip(
                          '${program['weeks']} minggu',
                          Icons.access_time,
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          '${program['exercises']} latihan',
                          Icons.fitness_center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(program['difficulty'] as String)
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        program['difficulty'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getDifficultyColor(program['difficulty'] as String),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Pemula':
        return const Color(0xFF10B981);
      case 'Menengah':
        return const Color(0xFF3B82F6);
      case 'Mahir':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

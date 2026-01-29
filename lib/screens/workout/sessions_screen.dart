import 'package:flutter/material.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  final Map<String, bool> _completedExercises = {};

  final sessionsToday = [
    {
      'name': 'Squat',
      'sets': 5,
      'reps': '5',
      'weight': '80 kg',
      'rest': '2 min',
      'icon': Icons.accessibility_new,
    },
    {
      'name': 'Bench Press',
      'sets': 5,
      'reps': '5',
      'weight': '60 kg',
      'rest': '2 min',
      'icon': Icons.fitness_center,
    },
    {
      'name': 'Deadlift',
      'sets': 1,
      'reps': '5',
      'weight': '100 kg',
      'rest': '3 min',
      'icon': Icons.sports_gymnastics,
    },
    {
      'name': 'Pull Ups',
      'sets': 3,
      'reps': '8-10',
      'weight': 'Body Weight',
      'rest': '90 sec',
      'icon': Icons.self_improvement,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final completedCount = _completedExercises.values.where((v) => v).length;
    final progress = completedCount / sessionsToday.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Sesi Hari Ini'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Progress Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF10B981),
                  const Color(0xFF059669),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Progress Hari Ini',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$completedCount/${sessionsToday.length} Selesai',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Exercises Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Latihan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Tambah'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Exercise Cards
          ...sessionsToday.asMap().entries.map((entry) {
            final exercise = entry.value;
            final key = exercise['name'] as String;
            final isCompleted = _completedExercises[key] ?? false;
            
            return _buildExerciseCard(exercise, isCompleted, () {
              setState(() {
                _completedExercises[key] = !isCompleted;
              });
              
              if (!isCompleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('✓ ${exercise['name']} selesai!'),
                    backgroundColor: const Color(0xFF10B981),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            });
          }),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
    Map<String, dynamic> exercise,
    bool isCompleted,
    VoidCallback onToggle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF10B981)
              : Colors.white.withValues(alpha: 0.1),
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    exercise['icon'] as IconData,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Exercise Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise['name'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${exercise['sets']} sets × ${exercise['reps']} reps',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Checkbox
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFF10B981)
                          : Colors.transparent,
                      border: Border.all(
                        color: isCompleted
                            ? const Color(0xFF10B981)
                            : const Color(0xFF6B7280),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              ],
            ),
            
            // Details
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailItem(
                    Icons.fitness_center,
                    'Beban',
                    exercise['weight'] as String,
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  _buildDetailItem(
                    Icons.timer,
                    'Istirahat',
                    exercise['rest'] as String,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6B7280)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

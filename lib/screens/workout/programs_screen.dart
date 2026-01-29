import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = [
      {'title': 'Beginner Full Body', 'weeks': 4},
      {'title': 'Strength Split', 'weeks': 6},
      {'title': 'HIIT Burn', 'weeks': 4},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Programs')),
      body: ListView.separated(
        itemCount: programs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final p = programs[i];
          return ListTile(
            title: Text(p['title'] as String),
            subtitle: Text('Durasi: ${p['weeks']} minggu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
        },
      ),
    );
  }
}

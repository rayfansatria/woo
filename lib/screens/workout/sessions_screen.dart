import 'package:flutter/material.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionsToday = [
      {'name': 'Squat', 'sets': 5, 'reps': '5'},
      {'name': 'Bench Press', 'sets': 5, 'reps': '5'},
      {'name': 'Deadlift', 'sets': 1, 'reps': '5'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sesi Hari Ini')),
      body: ListView.builder(
        itemCount: sessionsToday.length,
        itemBuilder: (_, i) {
          final s = sessionsToday[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(s['name'] as String),
              subtitle: Text('Sets: ${s['sets']}  Reps: ${s['reps']}'),
              trailing: IconButton(
                icon: const Icon(Icons.check_circle),
                onPressed: () {
                  ScaffoldMessenger.of(_).showSnackBar(
                    SnackBar(content: Text('Selesai: ${s['name']}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

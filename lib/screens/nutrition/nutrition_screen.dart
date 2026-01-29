import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = [
      {'name': 'Oatmeal + Banana', 'cal': 350},
      {'name': 'Chicken Salad', 'cal': 450},
      {'name': 'Greek Yogurt', 'cal': 150},
    ];
    final total = meals.fold<int>(0, (sum, m) => sum + (m['cal'] as int));

    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('Total Kalori: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$total kcal'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (_, i) {
                final m = meals[i];
                return ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: Text(m['name'] as String),
                  trailing: Text('${m['cal']} kcal'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Tambah Meal'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

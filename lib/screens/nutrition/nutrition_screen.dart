import 'package:flutter/material.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final meals = [
    {
      'name': 'Oatmeal + Banana',
      'cal': 350,
      'protein': 12,
      'carbs': 65,
      'fat': 6,
      'time': '07:30',
      'icon': Icons.breakfast_dining,
      'type': 'Sarapan',
    },
    {
      'name': 'Chicken Salad',
      'cal': 450,
      'protein': 35,
      'carbs': 25,
      'fat': 20,
      'time': '12:30',
      'icon': Icons.lunch_dining,
      'type': 'Makan Siang',
    },
    {
      'name': 'Greek Yogurt',
      'cal': 150,
      'protein': 15,
      'carbs': 12,
      'fat': 5,
      'time': '15:00',
      'icon': Icons.icecream,
      'type': 'Snack',
    },
    {
      'name': 'Salmon & Rice',
      'cal': 550,
      'protein': 40,
      'carbs': 50,
      'fat': 18,
      'time': '19:00',
      'icon': Icons.dinner_dining,
      'type': 'Makan Malam',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalCal = meals.fold<int>(0, (sum, m) => sum + (m['cal'] as int));
    final totalProtein = meals.fold<int>(0, (sum, m) => sum + (m['protein'] as int));
    final totalCarbs = meals.fold<int>(0, (sum, m) => sum + (m['carbs'] as int));
    final totalFat = meals.fold<int>(0, (sum, m) => sum + (m['fat'] as int));
    
    const targetCal = 2200;
    final calProgress = (totalCal / targetCal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Nutrisi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Calorie Summary Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'Kalori Hari Ini',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$totalCal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ' / $targetCal',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: calProgress,
                    minHeight: 10,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Macros Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMacroItem('Protein', totalProtein, 'g', const Color(0xFFEF4444)),
                    _buildMacroItem('Karbo', totalCarbs, 'g', const Color(0xFF3B82F6)),
                    _buildMacroItem('Lemak', totalFat, 'g', const Color(0xFF8B5CF6)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Meals Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Makanan Hari Ini',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                '${meals.length} items',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Meals List
          ...meals.map((m) => _buildMealCard(m)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMacroItem(String label, int value, String unit, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getMacroIcon(label),
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$value$unit',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  IconData _getMacroIcon(String label) {
    switch (label) {
      case 'Protein':
        return Icons.egg;
      case 'Karbo':
        return Icons.rice_bowl;
      case 'Lemak':
        return Icons.oil_barrel;
      default:
        return Icons.restaurant;
    }
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    meal['icon'] as IconData,
                    color: const Color(0xFFF59E0B),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Meal Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            meal['type'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: const Color(0xFF9CA3AF),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            meal['time'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Calories
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${meal['cal']} kcal',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Macros
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroDetail('P', meal['protein'] as int, const Color(0xFFEF4444)),
                  _buildMacroDetail('C', meal['carbs'] as int, const Color(0xFF3B82F6)),
                  _buildMacroDetail('F', meal['fat'] as int, const Color(0xFF8B5CF6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroDetail(String label, int value, Color color) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
        Text(
          '${value}g',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

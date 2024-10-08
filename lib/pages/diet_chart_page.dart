import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Chart Generator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 18.0),
        ),
      ),
      home: DietChartPage(),
    );
  }
}

class DietChartPage extends StatefulWidget {
  const DietChartPage({super.key});

  @override
  _DietChartPageState createState() => _DietChartPageState();
}

class _DietChartPageState extends State<DietChartPage> {
  final TextEditingController calorieController = TextEditingController();
  String selectedDiet = 'Vegetarian';
  String dietChart = '';

  void generateDietChart() {
    final int calories = int.tryParse(calorieController.text) ?? 0;

    if (calories > 0) {
      String chart = 'Diet Chart for $selectedDiet:\n';
      if (selectedDiet == 'Vegetarian') {
        chart += '1. Breakfast: Oatmeal with fruits (300 calories)\n';
        chart += '2. Lunch: Grilled vegetable salad (500 calories)\n';
        chart += '3. Dinner: Lentil curry with rice (600 calories)\n';
      } else if (selectedDiet == 'Non-Vegetarian') {
        chart += '1. Breakfast: Scrambled eggs with toast (400 calories)\n';
        chart += '2. Lunch: Chicken salad (600 calories)\n';
        chart += '3. Dinner: Grilled fish with vegetables (700 calories)\n';
      } else {
        chart += '1. Breakfast: Smoothie with almond milk (300 calories)\n';
        chart += '2. Lunch: Quinoa salad with chickpeas (500 calories)\n';
        chart += '3. Dinner: Stir-fried tofu with vegetables (600 calories)\n';
      }

      setState(() {
        dietChart = chart;
      });
    } else {
      setState(() {
        dietChart = 'Please enter a valid calorie intake.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Chart Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Diet Chart Generator',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Enter your daily calorie intake',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: calorieController,
                decoration: const InputDecoration(
                  labelText: 'Daily Calorie Intake',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedDiet,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDiet = newValue!;
                  });
                },
                items: <String>['Vegetarian', 'Non-Vegetarian', 'Vegan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateDietChart,
                child: const Text('Generate Diet Chart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                dietChart,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
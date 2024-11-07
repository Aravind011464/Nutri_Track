import 'package:flutter/material.dart';

class DietChartPage extends StatelessWidget {
  final int calories;
  final String lifestyle;

  const DietChartPage({Key? key, required this.calories, required this.lifestyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate average calories based on lifestyle multiplier
    double averageCalories = _calculateAverageCalories(calories, lifestyle);
    List<DietChart> dietChart = getDietChart(averageCalories.toInt()); // Get diet chart based on average calories

    return Scaffold(
      appBar: AppBar(
        elevation: 4, // Add some elevation for a subtle shadow effect
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent], // Gradient color for the AppBar
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Diet Chart', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White back button
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You need approximately ${averageCalories.toStringAsFixed(2)} calories per day based on your lifestyle: $lifestyle',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: dietChart.length,
                    itemBuilder: (context, index) {
                      final meal = dietChart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.meal,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ...meal.foodItems.map((item) => Text('${item.name}: ${item.calories} calories', style: const TextStyle(color: Colors.black))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Display total calories from diet chart with increased padding and font size
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0), // Increased padding
                  child: Text(
                    'Total Caloric Intake: ${_calculateTotalCalories(dietChart)} calories',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Increased font size and bold text
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateAverageCalories(int bmr, String lifestyle) {
    switch (lifestyle) {
      case 'Sedentary':
        return bmr * 1.2;
      case 'Slightly Active':
        return bmr * 1.375;
      case 'Moderately Active':
        return bmr * 1.55;
      case 'Active':
        return bmr * 1.725;
      case 'Very Active':
        return bmr * 1.9;
      default:
        return bmr.toDouble(); // Fallback to BMR if lifestyle is unrecognized
    }
  }

  int _calculateTotalCalories(List<DietChart> dietChart) {
    int totalCalories = 0;
    for (var meal in dietChart) {
      for (var item in meal.foodItems) {
        totalCalories += item.calories;
      }
    }
    return totalCalories;
  }
}

class DietChart {
  final String meal;
  final List<FoodItem> foodItems;

  DietChart(this.meal, this.foodItems);
}

class FoodItem {
  final String name;
  final int calories;

  FoodItem(this.name, this.calories);
}

List<DietChart> getDietChart(int totalCalories) {
  // Sample diet charts for different calorie intakes
  List<DietChart> dietChart = [];

  if (totalCalories <= 1500) {
    dietChart.add(DietChart('Breakfast', [
      FoodItem('Oatmeal (1 cup)', 150),
      FoodItem('Banana', 100),
      FoodItem('Black Coffee', 5),
    ]));
    dietChart.add(DietChart('Lunch', [
      FoodItem('Grilled Chicken Salad', 350),
      FoodItem('Whole Wheat Bread (2 slices)', 160),
      FoodItem('Apple', 95),
    ]));
    dietChart.add(DietChart('Dinner', [
      FoodItem('Baked Salmon (150g)', 350),
      FoodItem('Steamed Broccoli', 55),
      FoodItem('Quinoa (1 cup)', 222),
    ]));
    dietChart.add(DietChart('Snacks', [
      FoodItem('Greek Yogurt', 100),
      FoodItem('Almonds (1 oz)', 160),
    ]));
  } else if (totalCalories <= 2000) {
    dietChart.add(DietChart('Breakfast', [
      FoodItem('Scrambled Eggs (2)', 140),
      FoodItem('Whole Grain Toast', 70),
      FoodItem('Orange Juice (1 glass)', 110),
    ]));
    dietChart.add(DietChart('Lunch', [
      FoodItem('Turkey Sandwich', 400),
      FoodItem('Mixed Green Salad', 100),
      FoodItem('Pear', 100),
    ]));
    dietChart.add(DietChart('Dinner', [
      FoodItem('Grilled Steak (200g)', 500),
      FoodItem('Roasted Vegetables', 200),
      FoodItem('Brown Rice (1 cup)', 215),
    ]));
    dietChart.add(DietChart('Snacks', [
      FoodItem('Protein Bar', 200),
      FoodItem('Carrot Sticks with Hummus', 150),
    ]));
  } else {
    dietChart.add(DietChart('Breakfast', [
      FoodItem('Pancakes (2)', 300),
      FoodItem('Maple Syrup', 100),
      FoodItem('Bacon (3 slices)', 180),
    ]));
    dietChart.add(DietChart('Lunch', [
      FoodItem('Pasta Salad with Chicken', 500),
      FoodItem('Garlic Bread', 200),
      FoodItem('Ice Cream (1 scoop)', 200),
    ]));
    dietChart.add(DietChart('Dinner', [
      FoodItem('Lasagna', 600),
      FoodItem('Caesar Salad', 250),
      FoodItem('Cheese Breadsticks', 300),
    ]));
    dietChart.add(DietChart('Snacks', [
      FoodItem('Chocolate (2 squares)', 100),
      FoodItem('Mixed Nuts (1 oz)', 160),
    ]));
  }

  return dietChart;
}

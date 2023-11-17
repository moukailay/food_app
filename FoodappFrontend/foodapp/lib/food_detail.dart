import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> foodItem;

  const FoodDetailPage({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
        backgroundColor: const Color(0xff1E2E3D), // Customize the app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Food Name: ${foodItem['name']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1E2E3D), // Customize the text color
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Calorie: ${foodItem['characteristics']['calorie']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Lipid: ${foodItem['characteristics']['lipid']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Carbohydrate: ${foodItem['characteristics']['carbohydrate']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Protein: ${foodItem['characteristics']['protein']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              'Vitamin: ${foodItem['characteristics']['vitamin']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

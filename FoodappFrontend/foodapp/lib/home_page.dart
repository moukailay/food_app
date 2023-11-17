import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:foodapp/food_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FoodSearchScreen(),
    );
  }
}

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  List<Map<String, dynamic>> foodData = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/food.json');
    final jsonMap = json.decode(jsonString);
    if (jsonMap.containsKey('products')) {
      final products = jsonMap['products'];
      if (products is List) {
        setState(() {
          foodData = List<Map<String, dynamic>>.from(products);
        });
      }
    }
  }

  void search(String query) {
    query = query.toLowerCase();
    setState(() {
      searchResults = foodData.where((foodItem) {
        final name = foodItem['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void navigateToFoodDetail(Map<String, dynamic> foodItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FoodDetailPage(foodItem: foodItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Search'),
        backgroundColor: const Color(0xff1E2E3D),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                search(query);
              },
              decoration: const InputDecoration(labelText: 'Search for Food'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final foodItem = searchResults[index];
                return GestureDetector(
                  onTap: () {
                    navigateToFoodDetail(foodItem);
                  },
                  child: ListTile(
                    title: Text(foodItem['name']),
                    subtitle: Text(
                        'Calories: ${foodItem['characteristics']['calorie']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_app/features/home/data/db_helper/db_helper.dart';
import 'package:meal_app/features/home/data/models/meal_model.dart'; 

class HomeScreenProvider extends ChangeNotifier {
  List<Meal> _meals = [];
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Meal> get meals => _meals;

  Future<void> fetchMeals() async {
    _meals = await dbHelper.getMeals();
    notifyListeners();
  }
Future<void> addMeal(Meal meal) async {
    await dbHelper.insertMeal(meal);
    await fetchMeals();
  }
}

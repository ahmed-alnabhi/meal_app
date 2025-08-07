import 'package:meal_app/features/home/data/models/meal_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'meal_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
      ''' CREATE TABLE meals(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT , 
    imageUrl TEXT, 
    rating REAL, 
    time TEXT,
    description TEXT)
    ''');
  }
  Future<void> insertMeal(Meal meal) async {
    final Map<String, dynamic> mealmap = meal.toJson();
    final db = await database;
    await db.insert('meals', mealmap);
  }

  Future<List<Meal>> getMeals() async {
    final db = await database;
    List<Map<String, dynamic>> mealjson = await db.query('meals');
    List<Meal> meals = mealjson.map((mealjson){
      return Meal.fromJson(mealjson);
    }).toList();
    return meals;
  }

  // Future<void> deleteMeal(String name) async {
  //   final db = await database;
  //   await db.delete('meals', where: 'name = ?', whereArgs: [name]);
  // }
}

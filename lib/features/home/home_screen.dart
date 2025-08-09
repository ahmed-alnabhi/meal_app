import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';
import 'package:meal_app/core/style/routing/app_routes.dart';
import 'package:meal_app/features/home/data/db_helper/db_helper.dart';
import 'package:meal_app/features/home/home_screen_provider.dart';
import 'package:meal_app/features/home/widget/custom_bar_with_image.dart';
import 'package:meal_app/features/home/widget/meal_item.dart';
import 'package:provider/provider.dart';

DatabaseHelper dbHelper = DatabaseHelper();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeScreenProvider>(context, listen: false).fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppRoutes.addMeal);
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        child: Icon(Icons.add, color: Colors.orange, size: 32),
      ),
      body: Column(
        children: [
          CustomBarImageWithText(),
          SizedBox(height: 25),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Your Food",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.inter,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Consumer<HomeScreenProvider>(
                builder: (context, homeScreenProvider, child) {
                  if (homeScreenProvider.meals.isEmpty) {
                    return Center(
                      child: Text(
                        'No foods found',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  final meals = homeScreenProvider.meals;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 240,
                          // childAspectRatio: 0.7,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 20,
                        ),
                    itemCount: meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealItem(
                        imageUrl: meals[index].imageUrl,
                        name: meals[index].name,
                        rating: meals[index].rating.toString(),
                        time: meals[index].time.toString(),
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

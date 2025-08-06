import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> foods = [
    {
      'image': 'assets/images/burger.jpg',
      'name': 'Cheese Burger',
      'rating': 4.9,
      'time': '20 - 30',
    },
    {
      'image': 'assets/images/pasta.jpg',
      'name': 'Pasta',
      'rating': 4.9,
      'time': '20 - 30',
    },
    {
      'image': 'assets/images/breakfast.jpg',
      'name': 'Breakfast',
      'rating': 4.9,
      'time': '20 - 30',
    },
    {
      'image': 'assets/images/fries.jpg',
      'name': 'Fries',
      'rating': 4.9,
      'time': '20 - 30',
    },
       {
      'image': 'assets/images/fries.jpg',
      'name': 'Fries',
      'rating': 4.9,
      'time': '20 - 30',
    },
    {
      'image': 'assets/images/burger.jpg',
      'name': 'Cheese Burger',
      'rating': 4.9,
      'time': '20 - 30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        child: Icon(Icons.add, color: Colors.orange, size: 32),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/food_header.png",
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width * 0.12,
                child: Text(
                  " Welcome \n Add A New \n Recipe",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFont.inter,
                  ),
                ),
              ),
            ],
          ),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 240,
                 // childAspectRatio: 0.7,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 20,
        
                ),
                itemCount: foods.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Handle food item tap
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                                     //   margin: EdgeInsets.only( right: 5 , left: 5 , top: 5 , bottom: 5 ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              foods[index]['image'],
                              fit: BoxFit.cover,
                              height: 140,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            foods[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.inter,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: 4),
                              Text(
                                foods[index]['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFont.inter,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.timer,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: 4),
                               Text(
                                foods[index]['time'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFont.inter,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

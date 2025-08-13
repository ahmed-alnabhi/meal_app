import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';
import 'package:meal_app/features/home/data/models/meal_model.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: widget.meal.imageUrl.startsWith('assets/')
                            ? AssetImage(widget.meal.imageUrl) as ImageProvider
                            : FileImage(File(widget.meal.imageUrl)),
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 250,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image_outlined),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.meal.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFont.inter,
                      ),
                    ),
                    SizedBox(height: 22),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.meal.time,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF878787),
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.inter,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.meal.rating.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF878787),
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.inter,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Divider(color: Color(0xFFEDEDED), thickness: 2),
                    SizedBox(height: 20),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.inter,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.meal.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF878787),
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.inter,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rating;
  final String time;
  final VoidCallback onTap;
  const MealItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
                      onTap: onTap,
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
                                imageUrl,
                                fit: BoxFit.cover,
                                height: 140,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              name,
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
                                  rating,
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
                                  time,
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
  }
}


import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';

class customBarImageWithText extends StatelessWidget {
  const customBarImageWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
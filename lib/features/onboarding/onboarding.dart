import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentIndex = 0;
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Save Your \n Meals \n Ingredient',
      'subtitle':
          'Add Your Meals and its Ingredients \n and we will save it for you',
    },
    {
      'title': 'Use Our App \n The Best \n Choice',
      'subtitle': 'the best choice for your kitchen \n do not hesitate',
    },
    {
      'title': ' Our App \n Your Ultimate \n Choice',
      'subtitle':
          'All the best restaurants and their top \n menus are ready for you',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/onboarding.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 36,
            //  left: 20,
            right: 36,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              width: 300,
              height: 400,
              child: Column(
                children: [
                  ...List.generate(
                    _onboardingData.length,
                    (index) => _currentIndex == index
                        ? Text(
                            _onboardingData[index]['title']!,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 16),
                  ...List.generate(
                    _onboardingData.length,
                    (index) => _currentIndex == index
                        ? Text(
                            _onboardingData[index]['subtitle']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 6,
                        width: 24,
                        decoration: BoxDecoration(
                          color: _currentIndex == 0
                              ? Colors.white
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: 6,
                        width: 24,
                        decoration: BoxDecoration(
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: 6,
                        width: 24,
                        decoration: BoxDecoration(
                          color: _currentIndex == 2
                              ? Colors.white
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  _currentIndex + 1 != _onboardingData.length
                      ? Spacer()
                      : SizedBox(height: 30),
                  _currentIndex + 1 != _onboardingData.length
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "skip",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _currentIndex++;
                                  if (_currentIndex >= _onboardingData.length) {
                                    _currentIndex = 0;
                                  }
                                });
                              },
                              child: Text(
                                "next",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 55,
                          width: 55,
                          child: InkWell(
                            onTap: () {
                             
                            },
                            child: Center(
                              child: Icon(  Icons.arrow_forward, color: AppColors.primaryColor,)
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

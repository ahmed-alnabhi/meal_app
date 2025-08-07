import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/features/home/home.dart';
import 'package:meal_app/features/onboarding/onboarding_service/onboarding_services.dart';
import 'package:provider/provider.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
  bool isFirstTime = OnboardingServices.isFirstTime();
    if (!isFirstTime) {
      log("Not first time, navigating to HomeScreen");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      log("First time, showing onboarding screen");
      OnboardingServices.setFirstTime();
    }
    });
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);
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
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              width: 300,
              height: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: provider.pageController,
                      itemCount: provider.onboardingData.length,
                      onPageChanged: provider.setIndex,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.onboardingData[index]['title']!,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              provider.onboardingData[index]['subtitle']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      provider.onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 6,
                        width: 24,
                        decoration: BoxDecoration(
                          color: provider.currentIndex == index
                              ? Colors.white
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  provider.currentIndex + 1 != provider.onboardingData.length
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: provider.skipToEnd,
                              child: const Text(
                                "skip",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: provider.nextPage,
                              child: const Text(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: AppColors.primaryColor,
                              ),
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

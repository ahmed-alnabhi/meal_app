import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
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

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToEnd() {
    pageController.animateToPage(
      onboardingData.length - 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}


import 'package:go_router/go_router.dart';
import 'package:meal_app/core/style/routing/app_routes.dart';
import 'package:meal_app/features/add_meal/add_meal_screen.dart';
import 'package:meal_app/features/home/data/models/meal_model.dart';
import 'package:meal_app/features/home/home_screen.dart';
import 'package:meal_app/features/onboarding/onboarding_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.onBoardingScreen, routes: [
    GoRoute(
        path: AppRoutes.onBoardingScreen,
        name: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnboardingScreen()),
    GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: AppRoutes.addMeal,
        name: AppRoutes.addMeal,
        builder: (context, state) => const AddMealScreen()),
    // GoRoute(
    //     path: AppRoutes.mealDetailsScreen,
    //     name: AppRoutes.mealDetailsScreen,
    //     builder: (context, state) {
    //       Meal meal = state.extra as Meal;
    //       return MealDetailsScreen(
    //         meal: meal,
    //       );
    //     }),
  ]);
}
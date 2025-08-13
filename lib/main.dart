import 'package:flutter/material.dart';
import 'package:meal_app/core/style/routing/router_generation_config.dart';
import 'package:meal_app/features/home/home_screen_provider.dart';
import 'package:meal_app/features/onboarding/onboarding_service/onboarding_services.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/features/add_meal/add_meal_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OnboardingServices.initialSharedPreference();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => AddMealProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      routerConfig: RouterGenerationConfig.goRouter,
    );
  }
}

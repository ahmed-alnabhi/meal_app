import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/features/add_meal/widgets/custom_text_feild.dart';
import 'package:meal_app/features/add_meal/add_meal_provider.dart';
import 'package:meal_app/features/home/data/db_helper/db_helper.dart';
import 'package:meal_app/features/home/data/models/meal_model.dart';
import 'package:meal_app/features/home/home_screen_provider.dart';
import 'package:provider/provider.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();
  // Image path is managed by AddMealProvider

  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void addMeal() {
    final addMealProvider = context.read<AddMealProvider>();
    final String? imagePath = addMealProvider.imagePath;
    if (imagePath == null || imagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a photo for the meal')),
      );
      return;
    }
    Provider.of<HomeScreenProvider>(context, listen: false).addMeal(
      Meal(
        name: nameController.text.trim(),
        rating: double.tryParse(rateController.text.trim()) ?? 0.0,
        time: timeController.text.trim(),
        imageUrl: imagePath.trim(),
        description: descriptionController.text.trim(),
      ),
    );
    nameController.clear();
    rateController.clear();
    timeController.clear();
    descriptionController.clear();
    addMealProvider.clearImage();
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Add Meal",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        leading: Row(
          children: [
            SizedBox(width: 20),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.3),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ),
          ],
        ),
        leadingWidth: 70,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    "Meal Name",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hintText: "Breakfast",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a meal name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Rate",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hintText: "4.5",
                    controller: rateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter meal rate';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Time",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hintText: "20 - 30 m",
                    controller: timeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Time that this meal takes';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hintText: "• first\n• second",
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    contentHeight: 20,
                  ),
                  SizedBox(height: 18),

                  // Image picker / preview section (UX: placed above the primary action)
                  if (context.watch<AddMealProvider>().imagePath == null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: AppColors.primaryColor,
                            size: 36,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Add a photo for your meal',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 44,
                            child: OutlinedButton.icon(
                              onPressed: () => context
                                  .read<AddMealProvider>()
                                  .pickImage(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.primaryColor,
                              ),
                              label: Text(
                                'Add Photo',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(context.watch<AddMealProvider>().imagePath!),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => context
                                .read<AddMealProvider>()
                                .pickImage(context),
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Replace photo'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () =>
                                context.read<AddMealProvider>().clearImage(),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Remove'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addMeal();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Add Meal",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

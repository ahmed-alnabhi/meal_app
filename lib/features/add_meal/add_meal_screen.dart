import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/features/add_meal/widgets/custom_text_feild.dart';
import 'package:meal_app/core/utils/image_utils.dart';
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
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    rateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final bool? fromCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(true),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        );
      },
    );
    if (fromCamera == null) return;
    final file = await ImageUtils.pickAndSaveImage(fromCamera: fromCamera);
    if (file != null) {
      imageUrlController.text = file.path;
      setState(() {});
    }
  }

  void addMeal() {
    Provider.of<HomeScreenProvider>(context, listen: false).addMeal(
      Meal(
        name: nameController.text.trim(),
        rating: double.tryParse(rateController.text.trim()) ?? 0.0,
        time: timeController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        description: descriptionController.text.trim(),
      ),
    );
    nameController.clear();
    rateController.clear();
    timeController.clear();
    imageUrlController.clear();
    descriptionController.clear();
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
                    "Image URL",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  CustomTextField(
                    hintText: "Tap to pick an image",
                    controller: imageUrlController,
                    readOnly: true,
                    onTap: _pickImage,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please pick an image';
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
                  SizedBox(height: 70),

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

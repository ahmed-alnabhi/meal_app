
import 'package:flutter/material.dart';
import 'package:meal_app/core/style/colors.dart';
import 'package:meal_app/core/style/font.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isEnabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final double contentHeight;
  final dynamic onTap;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isEnabled = true,
    this.onTap,
    this.contentHeight = 16,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      onTap: widget.onTap,
      enabled: widget.isEnabled,
      cursorColor: AppColors.primaryColor,
      controller: widget.controller,
      validator: widget.validator,
      style: TextStyle(
        fontFamily: AppFont.inter,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        decoration: TextDecoration.none,
      
      ),
      decoration: InputDecoration(
          
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: widget.contentHeight,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        errorStyle: TextStyle(
          fontFamily: AppFont.inter,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.error,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: AppFont.inter,
          fontSize: 16,
          color: Colors.black.withValues(alpha: 0.4),
          fontWeight: FontWeight.w400,
    //      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black),
        ),

               
      ),
    );
  }
}
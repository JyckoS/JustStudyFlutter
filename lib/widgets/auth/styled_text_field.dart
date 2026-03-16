import 'package:flutter/material.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.labelMedium);
  }
}

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const StyledTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  OutlineInputBorder _border({bool focused = false}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: focused
              ? AppColors.primaryColor
              : AppColors.textSecondary.withOpacity(0.2),
          width: focused ? 2 : 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.bodyMedium.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.hint.copyWith(
          color: AppColors.textSecondary.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(focused: true),
      ),
    );
  }
}
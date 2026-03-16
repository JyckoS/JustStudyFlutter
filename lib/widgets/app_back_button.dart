import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.2),
          ),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.textColor,
          size: 18,
        ),
      ),
    );
  }
}
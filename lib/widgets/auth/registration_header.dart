import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '🎉  Let\'s get you started!',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
        const Gap(20),
        FadeInDown(
          delay: Duration(milliseconds: 100),
          child: Text(
            'Create\nAccount! ✨',
            style: AppTextStyles.displayLarge,
          ),
        ),
        const Gap(12),
        FadeInDown(
          delay: Duration(milliseconds: 200),
          child: Text(
            'Fill in your details to get started.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
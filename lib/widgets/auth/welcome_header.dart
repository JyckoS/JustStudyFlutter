import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart' show AppColors;
import 'package:juststudyflutterapp/constants/app_text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '☀️  Good to see you!',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        const Gap(20),
        FadeInDown(
          delay: Duration(milliseconds: 100),
          child: Text(
            'Welcome\nBack! 👋',
            style: AppTextStyles.displayLarge,
          ),
        ),
        const Gap(12),
        FadeInDown(
          delay: Duration(milliseconds: 200),
          child: Text(
            'Sign in to continue your journey.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
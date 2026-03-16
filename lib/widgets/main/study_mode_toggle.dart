import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';
import 'package:juststudyflutterapp/controllers/main/home_controller.dart';

class StudyModeToggle extends StatelessWidget {
  const StudyModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final current = controller.studyMode.value;
      final isRunning = controller.isRunning.value;

      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.textSecondary.withOpacity(0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Tab(
              label: 'Short Study',
              selected: current == StudyMode.short,
              disabled: isRunning,
              onTap: () => controller.switchMode(StudyMode.short),
            ),
            _Tab(
              label: 'Long Study',
              selected: current == StudyMode.long,
              disabled: isRunning,
              onTap: () => controller.switchMode(StudyMode.long),
            ),
          ],
        ),
      );
    });
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: selected
                ? Colors.white
                : disabled
                    ? AppColors.textSecondary.withOpacity(0.4)
                    : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
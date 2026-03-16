import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';
import 'package:juststudyflutterapp/controllers/auth/login_controller.dart';
import 'package:juststudyflutterapp/controllers/main/home_controller.dart';
import 'package:juststudyflutterapp/views/auth/login_screen.dart';
import 'package:juststudyflutterapp/widgets/main/leaderboard_section.dart';
import 'package:juststudyflutterapp/widgets/main/study_chart.dart';
import 'package:juststudyflutterapp/widgets/main/study_mode_toggle.dart';
import 'package:juststudyflutterapp/widgets/main/timer_circle.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());
  String convertMinutes(int minutes) {
    int mins = minutes % 60;
    int hours = (minutes / 60).toInt();
    int days = (hours / 24).toInt();
    String total = "$mins mins";
    if (hours > 0) {
      total = "$hours hours, $total";
    }
    if (days > 0) {
      total = "$days days, $total";
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── App Bar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: FadeInDown(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('JustStudy', style: AppTextStyles.headingLarge),
                        Text(
                          'Stay focused, stay winning.',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Obx(() {
                          return Text(
                            "You got this, ${controller.username.value}!",
                            style: AppTextStyles.bodyMedium,
                          );
                        }),
                        Obx(() {
                          return Text(
                            "So far, you have studied for ${convertMinutes((controller.totalStudyMinutes.value))}",
                            style: AppTextStyles.bodyMedium,
                          );
                        }),
                      ],
                    ),
                    // ── Logout Button ───────────────────────────────────
                    GestureDetector(
                      onTap: () {
                        loginController.logout();
                        Get.offAll(() => LoginScreen());
                      },
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
                          Icons.logout_rounded,
                          color: AppColors.errorColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Mode Toggle ───────────────────────────────────────────────
            FadeInDown(
              delay: Duration(milliseconds: 100),
              child: const StudyModeToggle(),
            ),

            const Gap(32),

            // ── Timer Circle ──────────────────────────────────────────────
            FadeInUp(
              delay: Duration(milliseconds: 200),
              child: const TimerCircle(),
            ),

            const Gap(36),

            // ── Divider ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.textSecondary.withOpacity(0.15),
                thickness: 1,
              ),
            ),

            const Gap(8),

            // ── Leaderboard ───────────────────────────────────────────────
            // ── Replace the leaderboard Expanded section in HomeScreen with this ───────
            Expanded(
              child: FadeInUp(
                delay: Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Chart (left) ──────────────────────────────────────────
                      Expanded(child: const StudyChart()),

                      // ── Divider ───────────────────────────────────────────────
                      VerticalDivider(
                        color: AppColors.textSecondary.withOpacity(0.15),
                        thickness: 1,
                        width: 1,
                      ),

                      // ── Leaderboard (right) ───────────────────────────────────
                      Expanded(child: const LeaderboardSection()),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

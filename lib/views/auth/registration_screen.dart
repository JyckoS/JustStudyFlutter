import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';
import 'package:juststudyflutterapp/controllers/auth/registration_controller.dart';
import 'package:juststudyflutterapp/widgets/app_back_button.dart';
import 'package:juststudyflutterapp/widgets/auth/register_button.dart';
import 'package:juststudyflutterapp/widgets/auth/registration_header.dart';
import 'package:juststudyflutterapp/widgets/auth/styled_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(8),
              FadeInDown(child: const AppBackButton()),
              const Gap(16),
              // ── Header ──────────────────────────────────────────────────
              FadeInDown(child: const RegistrationHeader()),

              const Gap(32),

              // ── Full Name ───────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 300),
                child: const FieldLabel(text: 'Full Name'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 350),
                child: StyledTextField(
                  controller: controller.fullNameController,
                  hint: 'John Doe',
                  icon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.name,
                ),
              ),

              const Gap(8),

              // ── Email ───────────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 400),
                child: const FieldLabel(text: 'Email'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 450),
                child: StyledTextField(
                  controller: controller.emailController,
                  hint: 'you@example.com',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const Gap(8),

              // ── Password ────────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 500),
                child: const FieldLabel(text: 'Password'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 550),
                child: Obx(() => StyledTextField(
                      controller: controller.passwordController,
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      obscureText: controller.obscurePassword.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
              ),

              const Gap(8),

              // ── Confirm Password ────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 600),
                child: const FieldLabel(text: 'Confirm Password'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 650),
                child: Obx(() => StyledTextField(
                      controller: controller.confirmPasswordController,
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      obscureText: controller.obscureConfirm.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirm.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        onPressed: controller.toggleConfirmVisibility,
                      ),
                    )),
              ),

              const Gap(16),

              // ── Register Button ─────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 700),
                child: Obx(() => RegisterButton(
                      isLoading: controller.isLoading.value,
                      onPressed: controller.handleRegister,
                    )),
              ),

              const Gap(16),

              // ── Login Link ──────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 750),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text('Log in', style: AppTextStyles.link),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
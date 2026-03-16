import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/constants/app_text_styles.dart';
import 'package:juststudyflutterapp/controllers/auth/login_controller.dart';
import 'package:juststudyflutterapp/views/auth/registration_screen.dart';
import 'package:juststudyflutterapp/widgets/auth/login_button.dart';
import 'package:juststudyflutterapp/widgets/auth/styled_text_field.dart';
import 'package:juststudyflutterapp/widgets/auth/welcome_header.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

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

              // ── Welcome Header ──────────────────────────────────────────
              FadeInDown(child: const WelcomeHeader()),

              const Gap(16),

              // ── Email ───────────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 300),
                child: const FieldLabel(text: 'Email'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 350),
                child: StyledTextField(
                  controller: controller.emailController,
                  hint: 'you@example.com',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const Gap(24),

              // ── Password ────────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 400),
                child: const FieldLabel(text: 'Password'),
              ),
              const Gap(8),
              FadeInUp(
                delay: Duration(milliseconds: 450),
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

              // ── Forgot Password ─────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 500),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.snackbar("Forgot password?", "Not my problem!");
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              // * ── Login Button ────────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 550),
                child: Obx(() => LoginButton(
                      isLoading: controller.isLoading.value,
                      onPressed: controller.handleLogin,
                    )),
              ),

              const Gap(16),

              // ── Create Account ──────────────────────────────────────────
              FadeInUp(
                delay: Duration(milliseconds: 600),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Get.to(() => SignUpScreen())
                          Get.to(() => RegistrationScreen());
                        },
                        child: Text('Create account', style: AppTextStyles.link),
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
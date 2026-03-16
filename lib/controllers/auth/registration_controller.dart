import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/services/auth_service.dart';
import 'package:juststudyflutterapp/views/main/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util.dart';

class RegistrationController extends GetxController {
  final AuthService _authService = AuthService();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;

  @override
  void onClose() {
    Debug.log("ON CLOSE REGISTER");
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  Future<void> handleRegister() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Oops!',
        'Passwords do not match.',
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    if (isLoading()) return;
    isLoading(true);
    final response = await _authService.register(
      fullNameController.text.trim(),
      emailController.text.trim().toLowerCase(),
      passwordController.text.trim(),
    );
    if (response['message'] == 'User registered successfully') {
      final loginResponse = await _authService.login(
        emailController.text.trim().toLowerCase(),
        passwordController.text.trim(),
      );
      String message = loginResponse['message'];
      if (message == "Login success!") {
        String token = loginResponse['token'];
        saveToken(token);

        Get.snackbar(
          "Successful!",
          "Registration completed.",
          colorText: AppColors.textColor,
          backgroundColor: AppColors.secondaryColor,
        );
        Get.to(HomeScreen());
      }
    } else {
      Get.snackbar(
        "ERROR!",
        "${response['message']}",
        colorText: AppColors.textColor,
        backgroundColor: AppColors.errorColor,
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    isLoading(false);
    // TODO: Add your registration logic here
  }

  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

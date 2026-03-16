import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juststudyflutterapp/constants/app_colors.dart';
import 'package:juststudyflutterapp/services/auth_service.dart';
import 'package:juststudyflutterapp/views/main/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading       = false.obs;
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
// * HANDLE LOGIN OF USERS

  Future<bool> hasValidSession() async {
    bool hasSession = await _authService.checkToken();
    Debug.log("HAS SESSION $hasSession");
    return await _authService.checkToken();
  }
  Future<void> handleLogin() async {
      if (isLoading()) {
      return;
    }
    isLoading(true);
    bool hasSession = await hasValidSession();

    // * No token session 
    if (!hasSession) {
      final response = await _authService.login(
        emailController.text.trim().toLowerCase(), passwordController.text.trim());
      String message = response['message'];
      // Sucess logged in, save token and move to home screen
      if (message == "Login success!") {
        String token = response['token'];
        saveToken(token);
        Get.to(() => HomeScreen());
      } else {
        Get.snackbar("Oops!", message, colorText: AppColors.textColor, backgroundColor: AppColors.errorColor);
      }
    } else {
      // User has session
      Get.to(() => HomeScreen());
    }
    
    await Future.delayed(const Duration(seconds: 2));
    isLoading(false);
    
  }
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
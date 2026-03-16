import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:juststudyflutterapp/controllers/auth/login_controller.dart';
import 'package:juststudyflutterapp/util.dart';
import 'package:juststudyflutterapp/views/auth/login_screen.dart';
import 'package:juststudyflutterapp/views/main/home_screen.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loginController.hasValidSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        final isLoggedIn = snapshot.data;
        if (!isLoggedIn!) {
          AppPresence.custom("JustStudy | Please login!");
          return LoginScreen();
        }
        AppPresence.custom("JustStudy | Welcome!");
        return HomeScreen();
      },

    ) ;
  }
}
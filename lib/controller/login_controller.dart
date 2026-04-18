 import 'package:flutter/material.dart';

import '../HomeScreen/home_screen.dart';
import '../model/login_request_model.dart';
import '../service/login_service.dart';

class AuthController {
  final AuthService _service = AuthService();

  Future<void> login({
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    LoginRequestModel request = LoginRequestModel(
      mobile: mobile,
      password: password,
    );

    final response = await _service.login(request);

    if (response.status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  Future<bool> checkLogin() async {
    return await _service.isLoggedIn();
  }

  Future<void> logout(BuildContext context) async {
    await _service.logout();

    Navigator.pushReplacementNamed(context, "/login");
  }
}

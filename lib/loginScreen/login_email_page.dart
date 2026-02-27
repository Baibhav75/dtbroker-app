import 'package:dtbroker/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/login_request_model.dart';
import '../service/login_service.dart';
import 'signup_page.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  static const Color primaryColor = Color(0xFF2D5016);
  static const Color accentColor = Color(0xFFE6C56F);
  static const Color backgroundColor = Color(0xFFF8FAF5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF1A2C0C);

  @override



  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    FocusScope.of(context).unfocus();

    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = LoginRequestModel(
        mobile: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final response = await _authService.login(request);

      if (response.status) {

        /// ✅ IMPORTANT: SAVE MOBILE FOR CHANGE PASSWORD
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("mobile", _emailController.text.trim());

        print("Saved Mobile: ${_emailController.text.trim()}");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
        );
      } else {
        _showMessage(response.message);
      }
    } catch (e) {
      _showMessage("Login failed");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscure,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: primaryColor),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          )
              : null,
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              Image.asset(
                'assets/images/niveshtital.png',
                height: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 10),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Login to your account to continue",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email or Mobile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildInputField(
                      controller: _emailController,
                      hintText: "Enter Mobile number",
                      icon: Icons.mail_outline,
                      obscure: false,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildInputField(
                      controller: _passwordController,
                      hintText: "Enter Password",
                      icon: Icons.lock_outline,
                      obscure: _obscurePassword,
                      isPassword: true,
                    ),

                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

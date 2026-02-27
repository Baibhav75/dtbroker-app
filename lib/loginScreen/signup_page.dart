import 'package:flutter/material.dart';

import '../controller/signup_controller.dart';
import '../model/signup_model.dart';
import 'login_email_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool agree = false;
  bool isLoading = false;

  final SignupController _controller = SignupController();

  void _signup() async {
    print("🔥 SIGNUP BUTTON CLICKED");

    // ✅ Empty Field Validation
    if (nameCtrl.text.trim().isEmpty ||
        emailCtrl.text.trim().isEmpty ||
        mobileCtrl.text.trim().isEmpty ||
        passCtrl.text.trim().isEmpty ||
        confirmCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    // ✅ Terms Validation
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accept Terms & Conditions")),
      );
      return;
    }

    // ✅ Password Length Validation
    if (passCtrl.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 6 characters"),
        ),
      );
      return;
    }

    // ✅ Confirm Password Match
    if (passCtrl.text.trim() != confirmCtrl.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    final model = SignupModel(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      password: passCtrl.text.trim(),
      confirmPassword: confirmCtrl.text.trim(),
      mobileNumber: mobileCtrl.text.trim(),
    );

    print("📤 Data Going To API: ${model.toJson()}");

    try {
      final result = await _controller.register(model);

      print("📥 Controller Result: $result");

      if (result == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful 🎉")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginEmailPage()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 35,
        elevation: 0,
        backgroundColor: bgColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 180,
                width: 370,
                child: Image.asset(
                  'assets/images/niveshtital.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _textField("Name", nameCtrl),
                    _textField("Email Address", emailCtrl),
                    _textField(
                      "Mobile Number",
                      mobileCtrl,
                      type: TextInputType.phone,
                    ),
                    _textField("Password", passCtrl, obscure: true),
                    _textField("Confirm Password", confirmCtrl, obscure: true),
                    CheckboxListTile(
                      value: agree,
                      onChanged: (v) => setState(() => agree = v!),
                      title: const Text("Please accept the Terms & Conditions"),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 10),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _primaryButton("Sign Up", _signup),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(
      String hint,
      TextEditingController controller, {
        bool obscure = false,
        TextInputType type = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _primaryButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffE6C56F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/changePassword_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final ChangePasswordController _controller = ChangePasswordController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  String mobileNumber = "";

  @override
  void initState() {
    super.initState();
    _loadMobile();
  }

  Future<void> _loadMobile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = prefs.getString("mobile") ?? "";
    });
    print("Loaded Mobile: $mobileNumber");
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.lock_outline, size: 130, color: Colors.blue),
              const SizedBox(height: 12),
              const Text(
                "Update your password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              _passwordField(
                controller: _oldPasswordController,
                label: "Old Password",
                obscure: _obscureOld,
                toggle: () => setState(() => _obscureOld = !_obscureOld),
              ),
              const SizedBox(height: 16),

              _passwordField(
                controller: _newPasswordController,
                label: "New Password",
                obscure: _obscureNew,
                toggle: () => setState(() => _obscureNew = !_obscureNew),
              ),
              const SizedBox(height: 16),

              _passwordField(
                controller: _confirmPasswordController,
                label: "Confirm New Password",
                obscure: _obscureConfirm,
                toggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }
                  if (value != _newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text("Change Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return "Required";
            }
            if (value.length < 6) {
              return "Minimum 6 characters";
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User session expired. Please login again."),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      print("Mobile Sent: $mobileNumber");
      print("Old Sent: ${_oldPasswordController.text.trim()}");
      print("New Sent: ${_newPasswordController.text.trim()}");
      print("Confirm Sent: ${_confirmPasswordController.text.trim()}");

      final message = await _controller.changePassword(
        mobile: mobileNumber,
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      if (message.toLowerCase().contains("success")) {
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error occurred")));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

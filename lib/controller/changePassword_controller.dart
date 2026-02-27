import '../service/changePassword_service.dart';

class ChangePasswordController {
  final ChangePasswordService _service = ChangePasswordService();

  Future<String> changePassword({
    required String mobile,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {

    if (newPassword != confirmPassword) {
      return "New and Confirm password do not match";
    }

    try {
      final response = await _service.changePassword(
        mobile: mobile,
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      print("API Status: ${response.status}");
      print("API Message: ${response.message}");

      return response.message;

    } catch (e) {
      print("Error: $e");
      return "Something went wrong. Please try again.";
    }
  }
}

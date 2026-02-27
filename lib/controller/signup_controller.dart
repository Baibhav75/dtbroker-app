import '../model/signup_model.dart';
import '../service/signup_service.dart';

class SignupController {
  final SignupService _service = SignupService();

  Future<String> register(SignupModel model) async {
    try {
      final response = await _service.registerUser(model);

      if (response.statusCode == 200) {
        return "Success";
      } else {
        return "Failed (${response.statusCode})";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}

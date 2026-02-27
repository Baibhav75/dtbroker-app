import 'package:dio/dio.dart';

import '../model/signup_model.dart';

class SignupService {
  final Dio _dio = Dio()
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

  Future<Response> registerUser(SignupModel model) async {
    print("📤 Sending Data: ${model.toJson()}");

    final response = await _dio.post(
      "https://niveshcore.com/api/signup/register",
      data: model.toJson(),
    );

    print("📥 Response Data: ${response.data}");
    print("📊 Status Code: ${response.statusCode}");

    return response;
  }
}

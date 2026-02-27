import 'package:flutter/material.dart';
import '../model/profile_get_model.dart';
import '../service/login_service.dart';
import '../service/profile_get_service.dart';

class ProfileController extends ChangeNotifier {

  final AuthService _authService = AuthService();
  final ProfileService _service = ProfileService();

  ProfileModel? profile;
  bool isLoading = false;

  Future<void> loadProfile() async {

    isLoading = true;
    notifyListeners();

    final userId = await _authService.getUserId();

    print("👤 Logged User ID: $userId");

    if (userId != null) {
      profile = await _service.fetchProfile(userId);
    }

    isLoading = false;
    notifyListeners();
  }
}

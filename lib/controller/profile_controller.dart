import 'package:flutter/material.dart';

import '../model/prfile_model.dart';
import '../service/profile_service.dart';


class ProfileUpdateController extends ChangeNotifier {

  final ProfileUpdateService _service =
  ProfileUpdateService();

  bool isLoading = false;

  Future<bool> updateProfile(
      ProfileUpdateRequestModel request) async {

    isLoading = true;
    notifyListeners();

    bool success =
    await _service.updateProfile(request);

    isLoading = false;
    notifyListeners();

    return success;
  }
}

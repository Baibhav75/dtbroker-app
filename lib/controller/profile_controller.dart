//
// import 'dart:io';
// import 'package:get/get.dart';
// import '../model/prfile_model.dart';
// import '../service/profile_service.dart';
//
// class ProfileController extends GetxController {
//
//   final ProfileService _service = ProfileService();
//
//   /// 🔥 OBSERVABLES
//   var isLoading = false.obs;
//   var profile = Rxn<ProfileModel>();
//
//   /// 🔽 LOAD PROFILE
//   Future<void> loadProfile() async {
//     try {
//       isLoading.value = true;
//
//       final result = await _service.getProfile();
//       profile.value = result;
//
//       print("✅ PROFILE LOADED: ${result.data?.name}");
//
//     } catch (e) {
//       print("❌ PROFILE ERROR: $e");
//       Get.snackbar("Error", "Failed to load profile");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// 🔽 UPDATE PROFILE
//   Future<void> updateProfile({
//     required String name,
//     required String email,
//     required String mobile,
//     required String state,
//     required String city,
//     required String address,
//     required String pincode,
//     File? image,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       final success = await _service.updateProfile(
//         name: name,
//         email: email,
//         mobile: mobile,
//         state: state,
//         city: city,
//         address: address,
//         pincode: pincode,
//         image: image,
//       );
//
//       if (success) {
//         Get.snackbar("Success", "Profile updated");
//
//         await loadProfile(); // 🔥 auto refresh
//
//         Get.back(result: true);
//       } else {
//         Get.snackbar("Error", "Update failed");
//       }
//
//     } catch (e) {
//       print("❌ UPDATE ERROR: $e");
//       Get.snackbar("Error", "Something went wrong");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:io';
import 'package:get/get.dart';
import '../model/prfile_model.dart';
import '../service/profile_service.dart';

class ProfileController extends GetxController {

  final ProfileService _service = ProfileService();

  /// 🔥 OBSERVABLES
  var isLoading = false.obs;
  var profile = Rxn<ProfileModel>();

  /// 🔽 LOAD PROFILE
  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      final result = await _service.getProfile();
      profile.value = result;

      print("✅ PROFILE LOADED: ${result.data?.name}");

    } catch (e) {
      print("❌ PROFILE ERROR: $e");

      /// 🔥 THROW ERROR (UI handle karega)
      throw Exception("Failed to load profile");

    } finally {
      isLoading.value = false;
    }
  }

  /// 🔽 UPDATE PROFILE
  Future<bool> updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String state,
    required String city,
    required String address,
    required String pincode,
    File? image,
  }) async {
    try {
      isLoading.value = true;

      final success = await _service.updateProfile(
        name: name,
        email: email,
        mobile: mobile,
        state: state,
        city: city,
        address: address,
        pincode: pincode,
        image: image,
      );

      if (success) {
        await loadProfile(); // 🔥 refresh
        return true;
      } else {
        return false;
      }

    } catch (e) {
      print("❌ UPDATE ERROR: $e");
      throw Exception("Something went wrong");

    } finally {
      isLoading.value = false;
    }
  }
}

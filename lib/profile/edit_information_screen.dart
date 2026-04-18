import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../model/prfile_model.dart';
import '../model/profile_get_model.dart';
import '../service/login_service.dart';
import 'package:get/get.dart';
class EditInformationPage extends StatefulWidget {
  final ProfileData profileData;
  const EditInformationPage({Key? key,
  required this.profileData,
  }) : super(key: key);

  @override
  State<EditInformationPage> createState() =>
      _EditInformationPageState();
}

class _EditInformationPageState
    extends State<EditInformationPage> {
  bool isLoading = false;
  // final ProfileUpdateController _controller =
  // ProfileUpdateController();
  final ProfileController controller = Get.find();
  final List<String> statesList = [
    "Uttar Pradesh",
    "Madhya Pradesh",
    "Delhi",
    "Rajasthan",
    "Bihar",
    "Gujarat",
    "Maharashtra",
    "Punjab",
    "Haryana",
  ];

  String? selectedState;


  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();

Future<void> _updateProfile() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final uniqueId =
      await const FlutterSecureStorage().read(key: "unique_id");

      if (uniqueId == null) return;

      print("🔑 UniqueId: $uniqueId");

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://niveshcore.com/api/user/edit-profile?uniqueId=$uniqueId"),
      );

      request.fields['Name'] = nameController.text;
      request.fields['Email'] = emailController.text;
      request.fields['MobileNumber'] = mobileController.text;
      request.fields['State'] = stateController.text;
      request.fields['City'] = cityController.text;
      request.fields['Address'] = addressController.text;
      request.fields['Pincode'] = pincodeController.text;

      /// 🔥 IMAGE UPLOAD
      if (selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "Profile",
            selectedImage!.path,
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfully")),
        );

        Navigator.pop(context, true);
      } else {
        print("❌ Update Failed: ${response.statusCode}");
      }

    } catch (e) {
      print("❌ ERROR: $e");
    } finally {
      setState(() => isLoading = false);
    }
  } @override
  void initState() {
    super.initState();

    nameController.text = widget.profileData.name ?? "";
    emailController.text = widget.profileData.email ?? "";
    mobileController.text = widget.profileData.mobileNumber ?? ""; // ✅ FIX
    stateController.text = widget.profileData.state ?? "";
    cityController.text = widget.profileData.city ?? "";
    addressController.text = widget.profileData.address ?? "";
    pincodeController.text = widget.profileData.pincode ?? "";
    selectedState = widget.profileData.state;
  }
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Information")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// 🔥 PROFILE IMAGE
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2D5016),
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : (widget.profileData.profile != null &&
                          widget.profileData.profile!.isNotEmpty)
                          ? NetworkImage(
                        "https://niveshcore.com${widget.profileData.profile!.replaceAll("~", "")}",
                      )
                          : null,
                      child: (selectedImage == null &&
                          (widget.profileData.profile == null ||
                              widget.profileData.profile!.isEmpty))
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                  ),

                  /// CAMERA BUTTON
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Color(0xFF2D5016),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// 🔥 NAME
              _premiumField(nameController, "Full Name", Icons.person),

              /// EMAIL
              _premiumField(emailController, "Email", Icons.email),

              /// MOBILE
              _premiumField(mobileController, "Mobile", Icons.phone),

              /// STATE DROPDOWN
              // DropdownButtonFormField<String>(
              //   value: selectedState,
              //   decoration: _inputDecoration("State", Icons.map),
              //   items: statesList.map((state) {
              //     return DropdownMenuItem(
              //       value: state,
              //       child: Text(state),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       selectedState = value;
              //       stateController.text = value ?? "";
              //     });
              //   },
              // ),
              DropdownButtonFormField<String>(
                value: statesList.contains(selectedState) ? selectedState : null,
                decoration: _inputDecoration("State", Icons.map),

                items: statesList.toSet().map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                    stateController.text = value ?? "";
                  });
                },
              ),

              const SizedBox(height: 12),

              _premiumField(cityController, "City", Icons.location_city),
              _premiumField(addressController, "Address", Icons.home),
              _premiumField(pincodeController, "Pincode", Icons.numbers),

              const SizedBox(height: 30),

              /// 🔥 UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5016),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isLoading ? null : _updateProfile,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Update Profile"),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _premiumField(
      TextEditingController controller,
      String label,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label, icon),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF2D5016)),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}

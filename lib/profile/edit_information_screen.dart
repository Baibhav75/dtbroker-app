import 'package:flutter/material.dart';
import '../controller/profile_controller.dart';
import '../model/prfile_model.dart';
import '../model/profile_get_model.dart';
import '../service/login_service.dart';

class EditInformationPage extends StatefulWidget {
  final Data profileData;
  const EditInformationPage({Key? key,
  required this.profileData,
  }) : super(key: key);

  @override
  State<EditInformationPage> createState() =>
      _EditInformationPageState();
}

class _EditInformationPageState
    extends State<EditInformationPage> {

  final ProfileUpdateController _controller =
  ProfileUpdateController();
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

    final authService = AuthService();
    final userId = await authService.getUserId();

    if (userId == null) return;

    final request = ProfileUpdateRequestModel(
      id: userId,
      name: nameController.text,
      email: emailController.text,
      mobileNumber: mobileController.text,
      password: passwordController.text,
      state: stateController.text,
      city: cityController.text,
      address: addressController.text,
      pincode: pincodeController.text,
    );

    bool success =
    await _controller.updateProfile(request);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
        ),
      );

      Navigator.pop(context, true);  //  IMPORTANT CHANGE
    }

  }
  @override
  void initState() {
    super.initState();

    nameController.text = widget.profileData.name ?? "";
    emailController.text = widget.profileData.email ?? "";
    mobileController.text = widget.profileData.mobile ?? "";
    stateController.text = widget.profileData.state ?? "";
    cityController.text = widget.profileData.city ?? "";
    addressController.text = widget.profileData.address ?? "";
    pincodeController.text = widget.profileData.pincode ?? "";
    selectedState = widget.profileData.state;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Information")),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                   SizedBox(
                     height: 10,
                   ),
              // ---------- PROFILE IMAGE ----------
              CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.blue,
              ),
            ),

              const SizedBox(height: 40),
                  _field(nameController, "Enter Name"),
                  _field(emailController, "Enter Email"),
                  _field(mobileController, "Enter Mobile"),
                 // _field(passwordController, "Password"),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DropdownButtonFormField<String>(
                      value: selectedState,
                      decoration: const InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(),
                      ),
                      items: statesList.map((state) {
                        return DropdownMenuItem(
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
                  ),

                  _field(cityController, "City"),
                  _field(addressController, "Address"),
                  _field(pincodeController, "Pincode"),

           SizedBox(
             height: 20,
           ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _controller.isLoading
                          ? null
                          : _updateProfile,
                      child: _controller.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Update"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
          ),
        ),
      ),
    );
  }
}

import 'package:dtbroker/profile/edit_information_screen.dart';
import 'package:flutter/material.dart';
import '../controller/profile_controller.dart';
import 'package:get/get.dart';

class MyInformationPage extends StatefulWidget {
  const MyInformationPage({Key? key}) : super(key: key);

  @override
  State<MyInformationPage> createState() => _MyInformationPageState();
}

class _MyInformationPageState extends State<MyInformationPage> {

  final ProfileController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        centerTitle: true,
      ),

      body: Obx(() {

        /// 🔥 LOADING
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.profile.value?.data;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔥 PROFILE IMAGE
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: (user?.profile != null &&
                      user!.profile.isNotEmpty)
                      ? NetworkImage(
                    "https://niveshcore.com${user.profile.replaceAll("~", "")}",
                  )
                      : null,
                  child: (user?.profile == null ||
                      user!.profile.isEmpty)
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
              ),

              const SizedBox(height: 12),

              /// 🔥 NAME
              Text(
                user?.name ?? "No Name",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              /// 🔥 EMAIL
              Text(
                user?.email ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              /// 🔥 INFO CARDS (PREMIUM)
              _infoCard(
                icon: Icons.phone,
                title: "Phone",
                value: user?.mobileNumber ?? "No Phone",
              ),

              _infoCard(
                icon: Icons.location_city,
                title: "City",
                value: user?.city ?? "No City",
              ),

              _infoCard(
                icon: Icons.map,
                title: "State",
                value: user?.state ?? "No State",
              ),

              _infoCard(
                icon: Icons.home,
                title: "Address",
                value: user?.address ?? "No Address",
              ),

              _infoCard(
                icon: Icons.pin_drop,
                title: "Pincode",
                value: user?.pincode ?? "No Pincode",
              ),

              const SizedBox(height: 30),

              /// 🔥 EDIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Information"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5016),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {

                    if (user == null) return;

                    final result = await Get.to(
                          () => EditInformationPage(profileData: user),
                    );

                    if (result == true) {
                      controller.loadProfile();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Color(0xFF2D5016)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

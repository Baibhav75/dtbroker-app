import 'dart:io';

import 'package:dtbroker/profile/how_it_works_page.dart';
import 'package:dtbroker/profile/my_deals_page.dart';
import 'package:dtbroker/profile/my_posted_properties_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../profile/AboutAppPage.dart';
import '../profile/My_information_page.dart';
import '../profile/support_page.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController controller = Get.find();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    controller.loadProfile();
  }

  // 📷 Open Camera
  Future<void> _openCamera() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      setState(() {
        _profileImage = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {

        /// 🔥 LOADING
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.profile.value?.data;

        return SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 30),

              /// 🔥 PROFILE IMAGE
              Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2D5016),
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (user?.profile != null &&
                            user!.profile.isNotEmpty)
                            ? NetworkImage(
                          "https://niveshcore.com${user.profile.replaceAll("~", "")}",
                        )
                            : null,
                        child: (_profileImage == null &&
                            (user?.profile == null ||
                                user!.profile.isEmpty))
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                    ),
                  ),

                  /// 📷 CAMERA BUTTON
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _openCamera,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
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

              const SizedBox(height: 16),

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
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 MENU CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                child: Column(
                  children: [

                    _menuItem(
                      icon: Icons.info_outline,
                      title: 'My Information',
                      onTap: () {
                        Get.to(() => const MyInformationPage());
                      },
                    ),

                    _menuItem(
                      icon: Icons.home_work_outlined,
                      title: 'My Posted Properties',
                      onTap: () {
                        Get.to(() => const MyPostedPropertiesPage());
                      },
                    ),

                    _menuItem(
                      icon: Icons.handshake_outlined,
                      title: 'My Deals',
                      onTap: () {
                        Get.to(() => const MyDealsPage());
                      },
                    ),

                    const Divider(),

                    _menuItem(
                      icon: Icons.help_outline,
                      title: 'How it Works',
                      onTap: () {
                        Get.to(() => const HowItWorksPage());
                      },
                    ),

                    _menuItem(
                      icon: Icons.support_agent_outlined,
                      title: 'Support',
                      onTap: () {
                        Get.to(() => const SupportPage());
                      },
                    ),

                    _menuItem(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        Get.to(() => const AboutAppPage());
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),

    );
  }

  // ---------- MENU ITEM ----------
  static Widget _menuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: Color(0xFF2D5016),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

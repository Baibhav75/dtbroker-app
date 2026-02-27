import 'dart:io';

import 'package:dtbroker/controller/profile_get_controller.dart';
import 'package:dtbroker/profile/how_it_works_page.dart';
import 'package:dtbroker/profile/my_deals_page.dart';
import 'package:dtbroker/profile/my_posted_properties_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile/AboutAppPage.dart';
import '../profile/My_information_page.dart';
import '../profile/support_page.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController _controller=ProfileController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  void initState(){
    super.initState();
    _controller.loadProfile();
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
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final user = _controller.profile?.data;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // ---------- PROFILE IMAGE ----------
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
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage('assets/images/homeimg.png')
                            as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: _openCamera,
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

                    const SizedBox(height: 12),

                    // ---------- DYNAMIC NAME ----------
                    Text(
                      user?.name ?? "Loading...",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ----- baaki menu same -----


                    // ---------- MENU LIST ----------
                    _menuItem(
                      icon: Icons.info_outline,
                      title: 'My Information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyInformationPage(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.home_work_outlined,
                      title: 'My Posted Properties',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyPostedPropertiesPage(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.handshake_outlined,
                      title: 'My Deals',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyDealsPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    _menuItem(
                      icon: Icons.help_outline,
                      title: 'How it Works',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HowItWorksPage(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.support_agent_outlined,
                      title: 'Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SupportPage(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.info_outline,
                      title: 'About',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AboutAppPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            ),
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

import 'package:dtbroker/HomeScreen/my_profile_screen.dart';
import 'package:dtbroker/profile/AboutAppPage.dart';
import 'package:dtbroker/profile/my_posted_properties_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../loginScreen/login_email_page.dart';
import '../profile/change_password_page.dart';
import '../profile/history_page.dart' show HistoryPage;
import '../profile/support_page.dart';
import '../service/login_service.dart';


class ProfileScreenContent extends StatefulWidget {
  ProfileScreenContent({super.key});

  @override
  State<ProfileScreenContent> createState() =>
      _ProfileScreenContentState();
  // final ProfileController controller = Get.find();
  static Widget _menuItem({
    required IconData icon,
    required String title,
    bool isLogout = false,
    bool isDanger = false,
    VoidCallback? onTap,
  }) {
    final Color iconColor = isDanger
        ? Colors.red
        : isLogout
        ? Colors.black
        : Colors.black87;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: iconColor,
                ),
              ),
            ),
            const Icon(Icons.chevron_right,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content:
        const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final authService = AuthService();
              await authService.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoginEmailPage()),
                    (route) => false,
              );
            },
            child: const Text('Logout',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreenContentState
    extends State<ProfileScreenContent> {
  final ProfileController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final user = controller.profile.value?.data;

      return SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 25),

            /// 🔥 PREMIUM PROFILE HEADER
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Row(
                children: [

                  /// 🔥 PROFILE IMAGE
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: (user?.profile != null &&
                        user!.profile.isNotEmpty)
                        ? NetworkImage(
                      "https://niveshcore.com${user.profile.replaceAll("~", "")}",
                    )
                        : null,
                    child: (user?.profile == null ||
                        user!.profile.isEmpty)
                        ? const Icon(Icons.person)
                        : null,
                  ),

                  const SizedBox(width: 14),

                  /// 🔥 NAME + EMAIL
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? "Loading...",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        user?.email ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 MENU LIST (PREMIUM)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () => Get.to(() => const MyProfileScreen()),
                  ),

                  _menuItem(
                    icon: Icons.home_work_outlined,
                    title: 'My Posted Properties',
                    onTap: () => Get.to(() => const MyPostedPropertiesPage()),
                  ),

                  _menuItem(
                    icon: Icons.history,
                    title: 'History',
                    onTap: () => Get.to(() => const HistoryPage()),
                  ),

                  _menuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () => Get.to(() => const ChangePasswordPage()),
                  ),

                  const Divider(),

                  _menuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms & Use',
                    onTap: () => Get.to(() => const SupportPage()),
                  ),

                  _menuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy & Policy',
                    onTap: () => Get.to(() => const SupportPage()),
                  ),

                  _menuItem(
                    icon: Icons.info_outline,
                    title: 'About App',
                    onTap: () => Get.to(() => const AboutAppPage()),
                  ),

                  _menuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    isLogout: true,
                    onTap: () {
                      ProfileScreenContent._showLogoutDialog(context);
                    },
                  ),

                  _menuItem(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    isDanger: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 🔥 PLAN CARD (OPTIONAL STATIC)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Basic Plan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '₹19.99',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '6 posts remaining',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Text("Upgrade"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      );
    });

  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    bool isLogout = false,
    bool isDanger = false,
    VoidCallback? onTap,
  }) {
    final Color iconColor = isDanger
        ? Colors.red
        : isLogout
        ? Colors.black
        : const Color(0xFF2D5016);

    final Color textColor = isDanger
        ? Colors.red
        : Colors.black87;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [

            /// 🔥 ICON BOX
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.withOpacity(0.1)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),

            const SizedBox(width: 14),

            /// 🔥 TITLE
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),

            /// 🔥 ARROW
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}





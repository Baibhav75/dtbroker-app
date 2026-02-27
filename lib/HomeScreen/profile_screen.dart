import 'package:dtbroker/HomeScreen/my_profile_screen.dart';
import 'package:dtbroker/profile/AboutAppPage.dart';
import 'package:dtbroker/profile/my_posted_properties_page.dart';
import 'package:flutter/material.dart';

import '../controller/profile_get_controller.dart';
import '../loginScreen/login_email_page.dart';
import '../profile/change_password_page.dart';
import '../profile/history_page.dart' show HistoryPage;
import '../profile/support_page.dart';
import '../service/login_service.dart';


class ProfileScreenContent extends StatefulWidget {
  const ProfileScreenContent({super.key});

  @override
  State<ProfileScreenContent> createState() =>
      _ProfileScreenContentState();

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
  final ProfileController _controller =
  ProfileController();

  @override
  void initState() {
    super.initState();
    _controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ---------- PROFILE HEADER ----------
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/homeimg.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.profile?.data?.name ?? "Loading...",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _controller.profile?.data?.email ?? "",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // -------- ALL UI BELOW SAME --------

              ProfileScreenContent._menuItem(
                icon: Icons.person_outline,
                title: 'My Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const MyProfileScreen()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.home_work_outlined,
                title: 'My Posted Properties',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const MyPostedPropertiesPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.history,
                title: 'History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const HistoryPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const ChangePasswordPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.description_outlined,
                title: 'Terms & Use',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const SupportPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy & Policy',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const SupportPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.info_outline,
                title: 'About App',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                        const AboutAppPage()),
                  );
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.logout,
                title: 'Logout',
                isLogout: true,
                onTap: () {
                  ProfileScreenContent
                      ._showLogoutDialog(context);
                },
              ),

              ProfileScreenContent._menuItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                isDanger: true,
                onTap: () {},
              ),

              const SizedBox(height: 25),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Basic Plan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$19.99',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '6 posts remaining',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Upgrade Premium',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}





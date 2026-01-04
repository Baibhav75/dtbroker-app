import 'package:dtbroker/HomeScreen/my_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // ---------- PROFILE HEADER ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/homeimg.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Aleen Shroff',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'aleenshroff123@gmail.com',
                      style: TextStyle(
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

          // ---------- MENU LIST ----------
          _menuItem(
            icon: Icons.person_outline,
            title: 'My Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyProfileScreen(),
                ),
              );
            },
          ),

          _menuItem(
            icon: Icons.home_work_outlined,
            title: 'My Posted Properties',
            onTap: () {
              // TODO: Navigate to Posted Properties screen
            },
          ),

          _menuItem(
            icon: Icons.history,
            title: 'History',
            onTap: () {
              // TODO: Navigate to History screen
            },
          ),

          _menuItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              // TODO: Navigate to Change Password screen
            },
          ),

          _menuItem(
            icon: Icons.description_outlined,
            title: 'Terms & Use',
            onTap: () {
              // TODO: Navigate to Terms screen
            },
          ),

          _menuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy & Policy',
            onTap: () {
              // TODO: Navigate to Privacy Policy screen
            },
          ),

          _menuItem(
            icon: Icons.info_outline,
            title: 'About App',
            onTap: () {
              // TODO: Navigate to About screen
            },
          ),

          _menuItem(
            icon: Icons.logout,
            title: 'Logout',
            isLogout: true,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),

          _menuItem(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            isDanger: true,
            onTap: () {
              // TODO: Delete account flow
            },
          ),

          const SizedBox(height: 24),

          // ---------- PLAN CARD ----------
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Upgrade plan
                    },
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
  }

  // ---------- MENU ITEM ----------
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ---------- LOGOUT DIALOG ----------
  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Clear session & navigate to login
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

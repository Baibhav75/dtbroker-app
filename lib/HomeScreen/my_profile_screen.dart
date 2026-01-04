import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
      body: SingleChildScrollView(
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
                    color: Color(0xFF2D5016), // green border
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage:
                    AssetImage('assets/images/homeimg.png'),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
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
              ],
            ),

            const SizedBox(height: 12),

            // ---------- NAME ----------
            const Text(
              'Melissa Peters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 32),

            // ---------- MENU LIST ----------
            _menuItem(
              icon: Icons.person_outline,
              title: 'My Information',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.home_work_outlined,
              title: 'My Posted Properties',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.handshake_outlined,
              title: 'My Deals',
              onTap: () {},
            ),

            const SizedBox(height: 16),

            _menuItem(
              icon: Icons.help_outline,
              title: 'How it Works',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.support_agent_outlined,
              title: 'Support',
              onTap: () {},
            ),
            _menuItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {},
            ),

            const SizedBox(height: 24),
          ],
        ),
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
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: const Color(0xFF2D5016),
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

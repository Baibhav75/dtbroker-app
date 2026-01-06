import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How It Works"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ---------- HEADER ----------
          const Icon(
            Icons.info_outline,
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "Simple steps to get started",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ---------- STEPS ----------
          _stepCard(
            step: "1",
            title: "Create Account",
            description:
            "Sign up using your mobile number or email to create your account.",
            icon: Icons.person_add,
          ),
          _stepCard(
            step: "2",
            title: "Complete Profile",
            description:
            "Fill in your personal details to make your profile complete.",
            icon: Icons.assignment_ind,
          ),
          _stepCard(
            step: "3",
            title: "Post or Browse Properties",
            description:
            "Post your property or browse available properties easily.",
            icon: Icons.home_work,
          ),
          _stepCard(
            step: "4",
            title: "Connect & Deal",
            description:
            "Connect with buyers or sellers and close the deal securely.",
            icon: Icons.handshake,
          ),
          _stepCard(
            step: "5",
            title: "Track & Manage",
            description:
            "Manage your posted properties, deals, and history from one place.",
            icon: Icons.dashboard,
          ),

          const SizedBox(height: 30),

          // ---------- FOOTER ----------
          const Center(
            child: Text(
              "That’s it! You’re ready to use the app 🚀",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= STEP CARD =================
  Widget _stepCard({
    required String step,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STEP CIRCLE
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // STEP CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.blue, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

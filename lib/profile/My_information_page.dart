import 'package:flutter/material.dart';

class MyInformationPage extends StatelessWidget {
  const MyInformationPage({Key? key}) : super(key: key);

  // ---------- USER DATA (replace with API later) ----------
  static const String name = "Ankur Kumar";
  static const String email = "ankur.kumar@email.com";
  static const String phone = "+91 98765 43210";
  static const String role = "Flutter Developer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ---------- PROFILE IMAGE ----------
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 12),

            // ---------- NAME ----------
            const Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // ---------- ROLE ----------
            const Text(
              role,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // ---------- INFO CARDS ----------
            _infoCard(
              icon: Icons.email,
              title: "Email",
              value: email,
            ),
            _infoCard(
              icon: Icons.phone,
              title: "Phone",
              value: phone,
            ),

            const SizedBox(height: 30),

            // ---------- EDIT BUTTON ----------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit Information"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Edit feature coming soon"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- INFO CARD ----------
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

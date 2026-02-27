import 'package:dtbroker/profile/edit_information_screen.dart';
import 'package:flutter/material.dart';
import '../controller/profile_get_controller.dart';

class MyInformationPage extends StatefulWidget {
  const MyInformationPage({Key? key}) : super(key: key);

  @override
  State<MyInformationPage> createState() => _MyInformationPageState();
}

class _MyInformationPageState extends State<MyInformationPage> {


  final ProfileController _controller = ProfileController();

  @override
  void initState() {
    super.initState();
    _controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {

          if (_controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = _controller.profile?.data;

          return SingleChildScrollView(
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
                Text(
                  user?.name ?? "No Name",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // ---------- ROLE (Optional Static) ----------
                const Text(
                  "User",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 24),

                // ---------- INFO CARDS ----------
                _infoCard(
                  icon: Icons.email,
                  title: "Email",
                  value: user?.email ?? "No Email",
                ),

                _infoCard(
                  icon: Icons.phone,
                  title: "Phone",
                  value: user?.mobile ?? "No Phone",
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

                const SizedBox(height: 30),

                // ---------- EDIT BUTTON ----------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Information"),
                    onPressed: () async {

                      final user = _controller.profile?.data;

                      if (user == null) return;

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditInformationPage(
                            profileData: user,
                          ),
                        ),
                      );

                      if (result == true) {
                        _controller.loadProfile();
                      }
                    },
                  ),
                ),

              ],
            ),
          );
        },
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

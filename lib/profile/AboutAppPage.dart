import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  // ---------- APP DETAILS ----------
  static const String appName = "DT Broker App";
  static const String version = "Version 1.0.0";
  static const String developer = "Developed by InfotechIndia";
  static const String description =
      "DT Broker App helps users manage properties, history, profile, and transactions efficiently with a modern and secure experience.";

  static const String privacyUrl = "https://example.com/privacy";
  static const String termsUrl = "https://example.com/terms";
  static const String email = "support@dtbroker.com";
  static const String appLink = "https://play.google.com/store/apps/details?id=com.example.app";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ---------- APP LOGO ----------
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.apps,
                size: 50,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 12),

            // ---------- APP NAME ----------
            const Text(
              appName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // ---------- VERSION ----------
            const Text(
              version,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // ---------- DESCRIPTION ----------
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            // ---------- MENU ITEMS ----------
            _item(
              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              onTap: () => _launchUrl(privacyUrl),
            ),
            _item(
              icon: Icons.description,
              title: "Terms & Conditions",
              onTap: () => _launchUrl(termsUrl),
            ),
            _item(
              icon: Icons.email,
              title: "Contact Support",
              onTap: () => _launchEmail(),
            ),
            _item(
              icon: Icons.star_rate,
              title: "Rate App",
              onTap: () => _launchUrl(appLink),
            ),
            _item(
              icon: Icons.share,
              title: "Share App",
              onTap: () => Share.share(
                "Check out this app: $appLink",
              ),
            ),

            const SizedBox(height: 30),

            // ---------- DEVELOPER ----------
            Text(
              developer,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "© 2026 All Rights Reserved",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- ITEM TILE ----------
  Widget _item({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ---------- OPEN URL ----------
  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // ---------- OPEN EMAIL ----------
  static Future<void> _launchEmail() async {
    final uri = Uri.parse("mailto:$email");
    if (!await launchUrl(uri)) {
      throw 'Could not open email';
    }
  }
}

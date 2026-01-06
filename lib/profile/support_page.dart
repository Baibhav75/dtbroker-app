import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  static const String supportPhone = "+919876543210";
  static const String supportEmail = "support@yourapp.com";
  static const String whatsappNumber = "+919876543210";

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  int _currentTab = 0; // 0 = Support, 1 = FAQ, 2 = Ticket

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentTab,
        children: [
          _supportView(),
          _faqView(),
          _ticketView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) => setState(() => _currentTab = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: "Support",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: "FAQs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Ticket",
          ),
        ],
      ),
    );
  }

  // ================= SUPPORT VIEW =================
  Widget _supportView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Icon(Icons.support_agent, size: 80, color: Colors.blue),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            "How can we help you?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),

        _tile(
          icon: Icons.call,
          title: "Call Support",
          subtitle: supportPhone,
          onTap: _callSupport,
        ),
        _tile(
          icon: Icons.email,
          title: "Email Support",
          subtitle: supportEmail,
          onTap: _emailSupport,
        ),
        _tile(
          icon: Icons.chat,
          title: "WhatsApp Support",
          subtitle: "Chat with us on WhatsApp",
          onTap: _openWhatsApp,
        ),
        _tile(
          icon: Icons.chat_bubble_outline,
          title: "Live Chat",
          subtitle: "Coming soon",
          onTap: () {
            _showMessage("Live chat coming soon");
          },
        ),

        const SizedBox(height: 20),
        const Center(
          child: Text(
            "Support Timing: Mon–Sat (10 AM – 6 PM)",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  // ================= FAQ VIEW =================
  Widget _faqView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ExpansionTile(
          title: Text("How do I reset my password?"),
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Go to settings → change password."),
            )
          ],
        ),
        ExpansionTile(
          title: Text("How do I contact support?"),
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Use call, email or WhatsApp options."),
            )
          ],
        ),
        ExpansionTile(
          title: Text("Is support free?"),
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Yes, support is completely free."),
            )
          ],
        ),
      ],
    );
  }

  // ================= TICKET VIEW =================
  Widget _ticketView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: "Subject",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Describe your issue",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitTicket,
              child: const Text("Submit Ticket"),
            ),
          )
        ],
      ),
    );
  }

  // ================= COMMON TILE =================
  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // ================= ACTION METHODS =================
  Future<void> _callSupport() async {
    await launchUrl(Uri.parse("tel:$supportPhone"));
  }

  Future<void> _emailSupport() async {
    await launchUrl(Uri.parse("mailto:$supportEmail"));
  }

  Future<void> _openWhatsApp() async {
    final url =
        "https://wa.me/${whatsappNumber.replaceAll('+', '')}";
    await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication);
  }

  void _submitTicket() {
    if (_subjectController.text.isEmpty ||
        _messageController.text.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    _showMessage("Ticket submitted successfully");
    _subjectController.clear();
    _messageController.clear();
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

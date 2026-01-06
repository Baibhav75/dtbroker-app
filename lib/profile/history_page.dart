import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  // Temporary dummy data (replace with API data later)
  final List<Map<String, String>> historyList = const [
    {
      "title": "Login Activity",
      "date": "05 Jan 2026",
      "time": "10:30 AM",
      "status": "Success",
    },
    {
      "title": "Password Changed",
      "date": "04 Jan 2026",
      "time": "06:15 PM",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: historyList.isEmpty
          ? _emptyState()
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final item = historyList[index];
          return _historyCard(item);
        },
      ),
    );
  }

  // ---------------- EMPTY STATE ----------------
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "No history available",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HISTORY CARD ----------------
  Widget _historyCard(Map<String, String> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.event_note, color: Colors.white),
        ),
        title: Text(
          item["title"] ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${item["date"]} • ${item["time"]}",
        ),
        trailing: Text(
          item["status"] ?? "",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

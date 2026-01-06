import 'package:flutter/material.dart';

class MyDealsPage extends StatefulWidget {
  const MyDealsPage({Key? key}) : super(key: key);

  @override
  State<MyDealsPage> createState() => _MyDealsPageState();
}

class _MyDealsPageState extends State<MyDealsPage> {
  // ---------------- DUMMY DEAL DATA ----------------
  final List<Map<String, dynamic>> _deals = [
    {
      "dealId": "DL-1001",
      "title": "2 BHK Apartment",
      "location": "Ahmedabad",
      "price": "₹45,00,000",
      "status": "Completed",
      "date": "05 Jan 2026",
    },
    {
      "dealId": "DL-1002",
      "title": "Commercial Shop",
      "location": "Surat",
      "price": "₹72,00,000",
      "status": "In Progress",
      "date": "02 Jan 2026",
    },
    {
      "dealId": "DL-1003",
      "title": "Villa Property",
      "location": "Vadodara",
      "price": "₹1,20,00,000",
      "status": "Cancelled",
      "date": "28 Dec 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Deals"),
        centerTitle: true,
      ),
      body: _deals.isEmpty ? _emptyView() : _dealList(),
    );
  }

  // ================= DEAL LIST =================
  Widget _dealList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _deals.length,
      itemBuilder: (context, index) {
        final deal = _deals[index];
        return _dealCard(deal);
      },
    );
  }

  // ================= DEAL CARD =================
  Widget _dealCard(Map<String, dynamic> deal) {
    Color statusColor;

    switch (deal["status"]) {
      case "Completed":
        statusColor = Colors.green;
        break;
      case "In Progress":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.red;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  deal["title"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    deal["status"],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 8),

            // ---------- DETAILS ----------
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  deal["location"],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.currency_rupee,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  deal["price"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  deal["date"],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ---------- ACTION ----------
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _showDealDetails(deal),
                child: const Text("View Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= EMPTY VIEW =================
  Widget _emptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.handshake_outlined,
              size: 80, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            "No deals found",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ================= DETAILS DIALOG =================
  void _showDealDetails(Map<String, dynamic> deal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Deal Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow("Deal ID", deal["dealId"]),
            _detailRow("Property", deal["title"]),
            _detailRow("Location", deal["location"]),
            _detailRow("Price", deal["price"]),
            _detailRow("Status", deal["status"]),
            _detailRow("Date", deal["date"]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

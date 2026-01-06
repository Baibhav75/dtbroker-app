import 'package:flutter/material.dart';

class MyPostedPropertiesPage extends StatefulWidget {
  const MyPostedPropertiesPage({Key? key}) : super(key: key);

  @override
  State<MyPostedPropertiesPage> createState() =>
      _MyPostedPropertiesPageState();
}

class _MyPostedPropertiesPageState
    extends State<MyPostedPropertiesPage> {
  // ---------------- DUMMY PROPERTIES ----------------
  List<Map<String, dynamic>> properties = [
    {
      "id": "PR-101",
      "title": "2 BHK Apartment",
      "location": "Ahmedabad",
      "price": "₹35,00,000",
      "status": "Active",
      "date": "05 Jan 2026",
    },
    {
      "id": "PR-102",
      "title": "Commercial Office",
      "location": "Surat",
      "price": "₹80,00,000",
      "status": "Inactive",
      "date": "01 Jan 2026",
    },
    {
      "id": "PR-103",
      "title": "Luxury Villa",
      "location": "Vadodara",
      "price": "₹1,40,00,000",
      "status": "Sold",
      "date": "22 Dec 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Posted Properties"),
        centerTitle: true,
      ),
      body: properties.isEmpty ? _emptyView() : _propertyList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ================= PROPERTY LIST =================
  Widget _propertyList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        return _propertyCard(properties[index], index);
      },
    );
  }

  // ================= PROPERTY CARD =================
  Widget _propertyCard(Map<String, dynamic> property, int index) {
    Color statusColor;
    switch (property["status"]) {
      case "Active":
        statusColor = Colors.green;
        break;
      case "Inactive":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.red;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
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
                Expanded(
                  child: Text(
                    property["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    property["status"],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 8),

            // ---------- LOCATION ----------
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  property["location"],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // ---------- PRICE ----------
            Row(
              children: [
                const Icon(Icons.currency_rupee,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  property["price"],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // ---------- DATE ----------
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  "Posted on ${property["date"]}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ---------- ACTION BUTTONS ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _viewProperty(property),
                  child: const Text("View"),
                ),
                TextButton(
                  onPressed: () => _editProperty(index),
                  child: const Text("Edit"),
                ),
                TextButton(
                  onPressed: () => _deleteProperty(index),
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
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
          Icon(Icons.home_work_outlined,
              size: 80, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            "No properties posted yet",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ================= ACTIONS =================
  void _viewProperty(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Property Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detail("ID", property["id"]),
            _detail("Title", property["title"]),
            _detail("Location", property["location"]),
            _detail("Price", property["price"]),
            _detail("Status", property["status"]),
            _detail("Date", property["date"]),
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

  void _editProperty(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Edit property: ${properties[index]["title"]}"),
      ),
    );
  }

  void _deleteProperty(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Property"),
        content: const Text(
            "Are you sure you want to delete this property?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                properties.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _addProperty() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Add Property screen coming soon"),
      ),
    );
  }

  Widget _detail(String title, String value) {
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

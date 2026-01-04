import 'package:flutter/material.dart';
import 'models/property_model.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// IMAGE SECTION
            Stack(
              children: [
                Image.asset(
                  property.imageUrl,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border, color: Colors.red),
                  ),
                ),
              ],
            ),

            /// CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE & PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          property.price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// LOCATION
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property.address,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// RATING & TYPE
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          " ${property.rating}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            property.tag,
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// DESCRIPTION
                    const Text(
                      "Property Description",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome to your dream home! This exquisite ${property.type} "
                          "is designed to provide comfort, luxury, and modern living. "
                          "Located in the heart of California with premium facilities.",
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),

                    const SizedBox(height: 20),

                    /// FACILITIES
                    const Text(
                      "Facilities",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        _Facility(icon: Icons.local_parking, label: "Parking"),
                        _Facility(icon: Icons.restaurant, label: "Restaurant"),
                        _Facility(icon: Icons.pool, label: "Swimming"),
                        _Facility(icon: Icons.fitness_center, label: "Gym"),
                        _Facility(icon: Icons.shopping_bag, label: "Shopping"),
                        _Facility(icon: Icons.local_laundry_service, label: "Laundry"),
                        _Facility(icon: Icons.park, label: "Garden"),
                        _Facility(icon: Icons.child_friendly, label: "Play area"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// BOOK BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Booking confirmed!")),
                    );
                  },
                  child: const Text(
                    "Book Now",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// FACILITY ITEM WIDGET
class _Facility extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Facility({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange.shade50,
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

import 'package:dtbroker/HomeScreen/models/property_model.dart';
import 'package:dtbroker/HomeScreen/property_detail_screen.dart';
import 'package:flutter/material.dart';

class PropertyListCard extends StatelessWidget {

  final Property property;

  const PropertyListCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(property: property),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
                  child:Image.asset(
                    property.imageUrl, // 'assets/images/homeimg.png'
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )

                ),

                // Share icon
                Positioned(
                  top: 12,
                  left: 12,
                  child: _circleIcon(Icons.share),
                ),

                // Heart icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: _circleIcon(Icons.favorite_border),
                ),
              ],
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        property.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 16),
                          const SizedBox(width: 4),
                          Text(property.rating.toString()),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        property.address,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Info row
                  Row(
                    children: [
                      _info(Icons.bed, '${property.bedrooms} Beds'),
                      const SizedBox(width: 12),
                      _info(Icons.bathtub, '${property.bathrooms} Bathrooms'),
                      const SizedBox(width: 12),
                      _info(Icons.square_foot, '${property.areaSqft} sqft'),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Owner + Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 14,
                            child: Icon(Icons.person, size: 16),
                          ),
                          const SizedBox(width: 6),
                          Text("Owner Name"),
                        ],
                      ),
                      Text(
                        property.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.green),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}

class FeatureListScreen extends StatelessWidget {
  final String title;
  final List<Property> properties;

  const FeatureListScreen({
    super.key,
    required this.title,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyListCard(
            property: properties[index],
          );
        },
      ),

    );
  }
}

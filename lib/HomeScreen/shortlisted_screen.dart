import 'package:flutter/material.dart';
import '../Agentchat/chat_page.dart';
import 'property_detail_screen.dart';
import '../model/property_model.dart';

class ShortlistedScreenContent extends StatefulWidget {
  const ShortlistedScreenContent({super.key});

  @override
  State<ShortlistedScreenContent> createState() =>
      _ShortlistedScreenContentState();
}

class _ShortlistedScreenContentState extends State<ShortlistedScreenContent> {
  final List<Property> _shortlistedProperties = [
    Property(
      id: '1',
      title: "The Urbun villa",
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.5,
      price: '₹ 82,909',

      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
    Property(
      id: '2',
      title: 'Skylight Serenity',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.8,
      price: '₹ 82,909',

      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
    Property(
      id: '3',
      title: 'Poolside villa',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.7,
      price: '₹ 82,909',

      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
    Property(
      id: '4',
      title: 'Predeep villa',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.7,
      price: '₹ 82,909',

      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${_shortlistedProperties.length} Properties are Shortlisted',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),

        /// LIST
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _shortlistedProperties.length,
            itemBuilder: (context, index) {
              final property = _shortlistedProperties[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE + TAG + REMOVE
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: Image.asset(
                              property.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          /// RENT TAG
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                property.tag,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /// REMOVE
                          Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _shortlistedProperties.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE
                            Text(
                              property.title,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            /// ADDRESS
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    property.address,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// PRICE + RATING
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  property.price,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      property.rating.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            /// BUTTONS
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      side: const BorderSide(color: Colors.orange),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ChatPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Chat",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              PropertyDetailScreen(property: property),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Book Now",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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

            },
          ),
        ),

      ],
    );
  }
}

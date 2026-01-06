import 'package:flutter/material.dart';
import '../Agentchat/chat_page.dart';
import 'property_detail_screen.dart';
import 'models/property_model.dart';

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
      price: '\$ 2290',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '2',
      title: 'Skylight Serenity',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.8,
      price: '\$ 2890',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '3',
      title: 'Poolside villa',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.7,
      price: '\$ 8290',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '4',
      title: 'Predeep villa',
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.7,
      price: '\$ 82909',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
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
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE + REMOVE
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                property.imageUrl,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _shortlistedProperties.removeAt(index);
                                  });
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// TITLE
                        Text(
                          property.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        /// ADDRESS
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                property.address,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// PRICE + RATING
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              property.price,
                              style: const TextStyle(
                                fontSize: 16,
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
                                Text(" ${property.rating}"),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>const ChatPage(
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Chat"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PropertyDetailScreen(
                                        property: property,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Book Now"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'models/property_model.dart';
import 'widgets/property_card.dart';

class SearchScreenContent extends StatefulWidget {
  const SearchScreenContent({super.key});

  @override
  State<SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  final List<Property> _allProperties = [
    Property(
      id: '1',
      title: "The Rao's villa",
      type: 'Villa',
      address: '2925 Woodside Road, California',
      rating: 4.5,
      price: '\$2290',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '2',
      title: 'Homestay Apartment',
      type: 'Apartment',
      address: 'Columbia Road, California',
      rating: 4.5,
      price: '\$1890',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '3',
      title: 'Modern Villa',
      type: 'Villa',
      address: '123 Main Street, California',
      rating: 4.8,
      price: '\$2990',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '4',
      title: 'Luxury Apartment',
      type: 'Apartment',
      address: '456 Park Avenue, California',
      rating: 4.7,
      price: '\$2490',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '5',
      title: 'Beachfront Villa',
      type: 'Villa',
      address: '789 Ocean Drive, California',
      rating: 4.8,
      price: '\$4590',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
  ];

  List<Property> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    _filteredProperties = _allProperties;
    _searchController.addListener(_filterProperties);
  }

  void _filterProperties() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProperties = _allProperties;
      } else {
        _filteredProperties = _allProperties.where((property) {
          return property.title.toLowerCase().contains(query) ||
              property.type.toLowerCase().contains(query) ||
              property.address.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light green
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by name, type, or location...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Villa', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Apartment', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Home', false),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProperties.length} Properties Found',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {
                    // Show filter dialog
                  },
                ),
              ],
            ),
          ),
          // Property list
          Expanded(
            child: _filteredProperties.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No properties found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredProperties.length,
                    itemBuilder: (context, index) {
                      return PropertyCard(
                        property: _filteredProperties[index],
                        onTap: () {
                          // Navigate to property details
                        },
                      );
                    },
                  ),
          ),
        ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFE8F5E9),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF2D5016) : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected
            ? const Color(0xFF2D5016)
            : Colors.grey.withOpacity(0.3),
      ),
    );
  }
}


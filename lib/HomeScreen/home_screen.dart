import 'package:dtbroker/HomeScreen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'models/property_model.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/property_card.dart';
import 'shortlisted_screen.dart';
import 'search_screen.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;
  bool _showSearchScreen = false;

  // Sample banner data
  final List<BannerItem> _banners = [
    BannerItem(
      id: '1',
      imageUrl: 'assets/images/homeimg.png',
      title: 'FIND YOUR DREAM HOME',
      subtitle: 'YOUR DREAM COME TRUE',
      description1:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse',
      description2:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse',
    ),
    BannerItem(
      id: '2',
      imageUrl: 'assets/images/homeimg.png',
      title: 'FIND YOUR DREAM HOME',
      subtitle: 'YOUR DREAM COME TRUE',
      description1:
          'Discover amazing properties with the best locations and prices.',
      description2:
          'Get personalized recommendations based on your preferences.',
    ),
  ];

  // Property categories
  final List<PropertyCategory> _categories = [
    PropertyCategory(
      id: '1',
      name: 'Home',
      icon: Icons.home,
    ),
    PropertyCategory(
      id: '2',
      name: 'Apartment',
      icon: Icons.apartment,
    ),
    PropertyCategory(
      id: '3',
      name: 'Villa',
      icon: Icons.villa,
    ),
    PropertyCategory(
      id: '4',
      name: 'P.G',
      icon: Icons.house,
    ),
  ];

  // Featured properties
  final List<Property> _featuredProperties = [
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
  ];

  // Newly added properties
  final List<Property> _newlyAddedProperties = [
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
  ];

  void _handleNavigation(int index) {
    if (index == 2) {
      // Add button - show dialog and stay on current screen
      _showAddPropertyDialog();
      return;
    }
    setState(() {
      _currentBottomNavIndex = index;
      _showSearchScreen = false;
    });
  }

  void _showAddPropertyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Property'),
        content: const Text('Add new property feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar or Top Navigation based on current screen
            _buildCurrentScreenAppBar(),
            // Body Content
            Expanded(
              child: _buildCurrentScreenBody(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCurrentScreenAppBar() {
    if (_showSearchScreen) {
      return _buildAppBar('Search Properties');
    }

    switch (_currentBottomNavIndex) {
      case 0:
        return Column(
          children: [
            _buildTopNavigation(),
            _buildSearchBar(),
          ],
        );
      case 1:
        return _buildAppBar('Shortlists');
      case 3:
        return _buildAppBar('Inbox', showSearchIcon: true);
      case 4:
        return _buildAppBar('Profile', showEditIcon: true);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCurrentScreenBody() {
    if (_showSearchScreen) {
      return const SearchScreenContent();
    }

    switch (_currentBottomNavIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const ShortlistedScreenContent();
      case 3:
        return const InboxScreenContent();
      case 4:
        return const ProfileScreenContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildAppBar(String title, {bool showSearchIcon = false, bool showEditIcon = false}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: _showSearchScreen || _currentBottomNavIndex != 0
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  if (_showSearchScreen) {
                    _showSearchScreen = false;
                  } else {
                    _currentBottomNavIndex = 0;
                  }
                });
              },
            )
          : null,
      actions: showSearchIcon
          ? [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Handle search
                },
              ),
            ]
          : showEditIcon
              ? [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      // Handle edit profile
                    },
                  ),
                ]
              : null,
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Carousel
          BannerCarousel(
            banners: _banners,
            height: 200,
          ),
          const SizedBox(height: 20),
          // Property Categories
          _buildPropertyCategories(),
          const SizedBox(height: 24),
          // Featured Property Section
          _buildSectionHeader('Featured Property', () {
            // Navigate to featured properties page
          }),
          const SizedBox(height: 12),
          _buildPropertyList(_featuredProperties),
          const SizedBox(height: 24),
          // Newly Added Property Section
          _buildSectionHeader('Newly added Property', () {
            // Navigate to newly added properties page
          }),
          const SizedBox(height: 12),
          _buildPropertyList(_newlyAddedProperties),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 4),
              const Text(
                'California, United States',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
          ),
          // Notifications
          GestureDetector(
            onTap: () {
              // Navigation code
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: 24,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSearchScreen = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9), // Light green
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 12),
            Text(
              'Search',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _buildCategoryItem(category);
        },
      ),
    );
  }

  Widget _buildCategoryItem(PropertyCategory category) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light green
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2D5016), // Dark green
                  width: 2,
                ),
              ),
              child: Icon(
                category.icon,
                color: const Color(0xFF2D5016), // Dark green
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'See all',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList(List<Property> properties) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyCard(
            property: properties[index],
            onTap: () {
              // Handle property tap - navigate to detail page
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          _handleNavigation(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2D5016), // Dark green
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentBottomNavIndex == 0
                    ? const Color(0xFF2D5016).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentBottomNavIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            label: 'Shortlisted',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700), // Yellow
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentBottomNavIndex == 3
                  ? Icons.inbox
                  : Icons.inbox_outlined,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentBottomNavIndex == 4
                  ? Icons.person
                  : Icons.person_outline,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


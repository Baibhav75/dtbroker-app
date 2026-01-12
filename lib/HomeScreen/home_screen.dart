import 'package:dtbroker/HomeScreen/notification_screen.dart';
import 'package:dtbroker/HomeScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'models/property_model.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/property_card.dart';
import 'shortlisted_screen.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;


  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  List<Property> _filteredFeatured = [];
  List<Property> _filteredNewlyAdded = [];

  // 📍 LIVE LOCATION STATE
  String _currentLocation = "Detecting location...";
  bool _isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    _getLiveLocation();
    _filteredFeatured = List.from(_featuredProperties);
    _filteredNewlyAdded = List.from(_newlyAddedProperties);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  // ================= LOCATION FUNCTION =================
  Future<void> _getLiveLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = "Location disabled";
          _isLocationLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = "Permission denied";
            _isLocationLoading = false;
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks.first;

      setState(() {
        _currentLocation =
        "${place.locality}, ${place.subLocality ?? place.administrativeArea}";
        _isLocationLoading = false;
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Location error";
        _isLocationLoading = false;
      });
    }
  }

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
      imageUrl: 'assets/images/testimagelogo.png',
      title: 'FIND YOUR DREAM HOME',
      subtitle: 'YOUR DREAM COME TRUE',
      description1:
          'Discover amazing properties with the best locations and prices.',
      description2:
          'Get personalized recommendations based on your preferences.',
    ),
    BannerItem(
      id: '3',
      imageUrl: 'assets/images/bookimg.png',
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
      name: 'House',
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
      name: 'plot',
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
      price: '₹2990',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '2',
      title: 'Homestay Apartment',
      type: 'Apartment',
      address: 'Columbia Road, California',
      rating: 4.5,
      price: '₹2990',
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
      price: '₹2990',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
    Property(
      id: '4',
      title: 'Luxury Apartment',
      type: 'Apartment',
      address: '456 Park Avenue, California',
      rating: 4.7,
      price: '₹2990',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
    ),
  ];

  void _handleNavigation(int index) {
    if (index == 2) {
      // ✅ Navigate to SearchHomePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>  SearchScreenContent(),
        ),
      );
      return; // ❗ DO NOT update bottom index
    }

    setState(() {
      _currentBottomNavIndex = index;
    });
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
        return _buildAppBar('Inbox');
      case 4:
        return _buildAppBar('Profile');
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCurrentScreenBody() {
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


  Widget _buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
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
        _buildPropertyList(_filteredFeatured),

        const SizedBox(height: 24),
          // Newly Added Property Section
          _buildSectionHeader('Newly added Property', () {
            // Navigate to newly added properties page
          }),
          const SizedBox(height: 12),
          _buildPropertyList(_filteredNewlyAdded),
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
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 6),
              _isLocationLoading
                  ? const Text("Detecting location...")
                  : Text(
                _currentLocation,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  void _onSearchChanged(String query) {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      final searchText = query.toLowerCase().trim();

      setState(() {
        if (searchText.isEmpty) {
          _filteredFeatured = List.from(_featuredProperties);
          _filteredNewlyAdded = List.from(_newlyAddedProperties);
          return;
        }

        bool matches(Property p) {
          return p.title.toLowerCase().contains(searchText) ||
              p.type.toLowerCase().contains(searchText) ||
              p.address.toLowerCase().contains(searchText) ||
              p.tag.toLowerCase().contains(searchText);
        }

        _filteredFeatured =
            _featuredProperties.where(matches).toList();

        _filteredNewlyAdded =
            _newlyAddedProperties.where(matches).toList();
      });
    });
  }



  // 🔍 SEARCH → NEW PAGE
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          icon: const Icon(Icons.search),
          hintText: "Search by name, type, location...",
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _searchController.clear();
              _onSearchChanged('');
            },
          )
              : null,
          border: InputBorder.none,
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


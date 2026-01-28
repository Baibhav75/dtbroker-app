import 'package:dtbroker/HomeScreen/notification_screen.dart';
import 'package:dtbroker/HomeScreen/search_screen.dart';
import 'package:dtbroker/HomeScreen/seeAllListPage.dart';
import 'package:dtbroker/HomeScreen/property_detail_screen.dart';
import 'package:dtbroker/HomeScreen/widgets/recommended_card.dart';
import 'package:dtbroker/FlipCardLocationPage.dart';
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
  int _selectedCategoryIndex = 0; // default selected (House)


  final TextEditingController _searchController = TextEditingController();
  Timer? _searchDebounce;
  List<Property> _filteredFeatured = [];
  List<Property> _filteredNewlyAdded = [];
  List<Property> _recommendedProperties = [];


  // 📍 LIVE LOCATION STATE
  String _currentLocation = "Detecting location...";
  bool _isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    _getLiveLocation();
    _filteredFeatured = List.from(_featuredProperties);
    _filteredNewlyAdded = List.from(_newlyAddedProperties);
    _recommendedProperties = List.from(_featuredProperties.reversed);
    // 👇 NEW

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
  void _filterPropertiesByCategory(String categoryName) {
    setState(() {
      if (categoryName.toLowerCase() == 'house') {
        _filteredFeatured =
            _featuredProperties.where((p) => p.type == 'House').toList();
        _filteredNewlyAdded =
            _newlyAddedProperties.where((p) => p.type == 'House').toList();
      } else if (categoryName.toLowerCase() == 'apartment') {
        _filteredFeatured =
            _featuredProperties.where((p) => p.type == 'Apartment').toList();
        _filteredNewlyAdded =
            _newlyAddedProperties.where((p) => p.type == 'Apartment').toList();
      } else if (categoryName.toLowerCase() == 'villa') {
        _filteredFeatured =
            _featuredProperties.where((p) => p.type == 'Villa').toList();
        _filteredNewlyAdded =
            _newlyAddedProperties.where((p) => p.type == 'Villa').toList();
      } else {
        // fallback → show all
        _filteredFeatured = List.from(_featuredProperties);
        _filteredNewlyAdded = List.from(_newlyAddedProperties);
      }
    });
  }
  final List<CityItem> cities = [
    CityItem(
      name: 'Delhi / NCR',
      image: 'https://images.unsplash.com/photo-1587474260584-136574528ed5',
    ),
    CityItem(
      name: 'Mumbai',
      image: 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f',
    ),
    CityItem(
      name: 'Bangalore',
      image: 'https://images.unsplash.com/photo-1596176530529-78163a4f7af2',
    ),
    CityItem(
      name: 'Hyderabad',
      image: 'https://images.unsplash.com/photo-1600788910554-5f2a7d63f42c',
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
      name: 'Plot',
      icon: Icons.house_siding,
    ),
  ];



  // Featured properties
  final List<Property> _featuredProperties = [
    Property(
      id: '1',
      title: "Luxury Villa",
      type: 'Villa',
      address: 'Beverly Hills, California',
      rating: 4.9,
      price: '₹45,000',
      imageUrl: 'assets/images/Buyingimage.png',
      tag: 'Rent',
      bedrooms: 4,
      bathrooms: 3,
      areaSqft: 2400,
      ownerName: 'Rahul Sharma',
      
      ownerLogo: 'assets/images/Buyingimage.png',
      growthRate: '20% Growing',
    ),
    Property(
      id: '2',
      title: 'Modern Apartment',
      type: 'Apartment',
      address: 'Downtown LA, California',
      rating: 4.7,
      price: '₹32,000',
      imageUrl: 'assets/images/Buyingimage.png',
      tag: 'Rent',
      bedrooms: 3,
      bathrooms: 2,
      areaSqft: 1800,ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
      growthRate: '20% Growing',

    ),
    Property(
      id: '3',
      title: 'Family House',
      type: 'House',
      address: 'San Jose, California',
      rating: 4.6,
      price: '₹28,000',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Sale',
      bedrooms: 4,
      bathrooms: 3,
      areaSqft: 2100,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
      growthRate: '20% Growing',
    ),
    Property(
      id: '4',
      title: 'City View Apartment',
      type: 'Apartment',
      address: 'San Francisco, California',
      rating: 4.8,
      price: '₹40,000',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Rent',
      bedrooms: 2,
      bathrooms: 2,
      areaSqft: 1500,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
    Property(
      id: '5',
      title: 'Premium Villa',
      type: 'Villa',
      address: 'Palo Alto, California',
      rating: 5.0,
      price: '₹60,000',
      imageUrl: 'assets/images/homeimg.png',
      tag: 'Sale',
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
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
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',

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
      bedrooms: 5,
      bathrooms: 4,
      areaSqft: 3200,
      ownerName: 'Rahul Sharma',
      ownerLogo: 'assets/images/owner1.png',
    ),
  ];

  String _currentAddress = "Vijay Nagar, MP";




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
      drawer: _buildDrawer(), // ✅ ADD THIS
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


          // Property Categories
          //property Categories like Home , Pg, Rent, house
          // Featured Property Section
          _buildSectionHeader('Featured Property', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FeatureListScreen(
                  title: 'Featured Property',
                  properties: _filteredFeatured,
                ),
              ),

            );
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
          
          const SizedBox(height: 24),
          // Recommended For You Section
          _buildSectionHeader('Recommended For You', () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FeatureListScreen(
                  title: 'Recommended For You',
                  properties: _recommendedProperties,
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          const SizedBox(height: 12),
          _buildRecommendedList(_recommendedProperties),
          
          const SizedBox(height: 20),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 EXPLORE POPULAR CITIES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Explore popular cities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Buy or Rent properties in top cities',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];

              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.network(
                        city.image,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: 72,
                            height: 72,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 72,
                            height: 72,
                            color: Colors.grey[300],
                            child: const Icon(Icons.location_city),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      city.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),


        const SizedBox(height: 24),

            // 🔹 BUYING COMMERCIAL PROPERTY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Buying a commercial property',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Shops, offices, land, factories, warehouses and more',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/Buyingimage.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Explore all commercial buying options',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Over 79,000 properties and 9,500 projects',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 TOP ARTICLES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.article_outlined),
                  SizedBox(width: 8),
                  Text(
                    'Top articles on commercial buying',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Know more about latest realty trends',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 TABS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                children: const [
                  Text('News', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('Tax & Legal'),
                  Text('Help Guides'),
                  Text('Investment'),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      )


      ],
      ),
    );
  }

  Widget _buildTopNavigation({bool isDarkMode = false}) {
    final bgColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subTextColor = isDarkMode ? Colors.white70 : Colors.black87;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.4 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ☰ MENU + LOCATION
          Row(
            children: [
              // ☰ Drawer Button
              Builder(
                builder: (context) => InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white10
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.menu_open_rounded,
                      color: textColor,
                      size: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // 📍 LOCATION (ANIMATED)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.4),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FlipCardLocationPage(
                          currentLocation: _currentLocation,
                          onLocationUpdated: (newLocation) {
                            setState(() {
                              _currentLocation = newLocation;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    key: ValueKey(_currentLocation),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      key: ValueKey('$_currentLocation$_currentAddress'),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(width: 10),

                          // 📍 LOCATION + ADDRESS (ROW WISE)
                          _isLocationLoading
                              ? const Text(
                            "Detecting...",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                              : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentLocation,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: subTextColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  _currentAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: subTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 6),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.red,
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),

          // 👤 PROFILE AVATAR + 🔴 NOTIFICATION BADGE
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationScreen(),
                ),
              );
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                  isDarkMode ? Colors.white10 : Colors.grey.shade200,
                  backgroundImage:
                  const AssetImage('assets/images/profile.png'),
                  child: const Icon(Icons.notification_add, color: Colors.black),
                ),

                // 🔴 NOTIFICATION BADGE
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: bgColor, width: 2),
                    ),
                    child: const Text(
                      '3', // 🔔 notification count
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildCategoryItem(
      PropertyCategory category,
      int index,
      bool isSelected,
      ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
        _filterPropertiesByCategory(category.name);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isSelected
              ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEAF4FF),
              Color(0xFFD6E8FF),
            ],
          )
              : const LinearGradient(
            colors: [Colors.white, Colors.white],
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.25),
                blurRadius: 14,
                offset: const Offset(0, 8),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
          border: Border.all(
            color: isSelected
                ? Colors.blue.withOpacity(0.4)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 Icon Animation
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: isSelected ? 1.25 : 1.0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: isSelected ? const Offset(0, -0.05) : Offset.zero,
                child: Icon(
                  category.icon,
                  size: 30,
                  color: isSelected
                      ? const Color(0xFF1E88E5)
                      : Colors.black54,
                ),
              ),
            ),

            // 🔤 Text Animation
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF1E88E5)
                    : Colors.black54,
              ),
              child: Text(category.name),
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

          // ✅ InkWell added
          InkWell(
            onTap: onSeeAll,
            borderRadius: BorderRadius.circular(6),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPropertyList(List<Property> properties) {
    return SizedBox(
      height: 340,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyCard(
            property: properties[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyDetailScreen(
                    property: properties[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRecommendedList(List<Property> properties) {
    return SizedBox(
      height: 290, // Increased height to prevent overflow
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)), // Slide up
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: RecommendedCard(
              property: properties[index],
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PropertyDetailScreen(
                      property: properties[index],
                    ),
                  ),
                );
              },
            ),
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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _handleNavigation,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2D5016),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          _navItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _navItem(
            icon: Icons.favorite_border,
            activeIcon: Icons.favorite,
            label: 'Shortlisted',
            index: 1,
          ),

          /// 🔥 Center Add Button
          BottomNavigationBarItem(
            icon: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 28),
            ),
            label: '',
          ),

          _navItem(
            icon: Icons.inbox_outlined,
            activeIcon: Icons.inbox,
            label: 'Inbox',
            index: 3,
          ),
          _navItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            index: 4,
          ),
        ],
      ),
    );
  }
  BottomNavigationBarItem _navItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        _currentBottomNavIndex == index ? activeIcon : icon,
      ),
      label: label,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
        child: Column(
          children: [
            // 🔹 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2D5016),
                    Color(0xFF3F7D20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 38,
                      color: Color(0xFF2D5016),
                    ),
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 8),

            _drawerItem(Icons.home_outlined, 'Home', () {
              Navigator.pop(context);
            }),

            _drawerItem(Icons.favorite_border, 'Shortlisted', () {
              setState(() => _currentBottomNavIndex = 1);
              Navigator.pop(context);
            }),

            _drawerItem(Icons.inbox_outlined, 'Inbox', () {
              setState(() => _currentBottomNavIndex = 3);
              Navigator.pop(context);
            }),

            _drawerItem(Icons.person_outline, 'Profile', () {
              setState(() => _currentBottomNavIndex = 4);
              Navigator.pop(context);
            }),

            const Spacer(),

            const Divider(thickness: 1),

            _drawerItem(
              Icons.logout,
              'Logout',
                  () {
                Navigator.pop(context);
                setState(() => _currentBottomNavIndex = 0);
              },
              iconColor: Colors.red,
              textColor: Colors.red,
            ),

            const SizedBox(height: 12),
          ],
        ),

    );
  }

  Widget _drawerItem(
      IconData icon,
      String title,
      VoidCallback onTap, {
        Color iconColor = Colors.black87,
        Color textColor = Colors.black87,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Icon(icon, color: iconColor, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        horizontalTitleGap: 10,
        dense: true,
        splashColor: Colors.green.withOpacity(0.15),
        hoverColor: Colors.green.withOpacity(0.05),
      ),
    );
  }


}

class CityItem {
  final String name;
  final String image;

  CityItem({required this.name, required this.image});
}





import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'models/property_model.dart';

class PropertyDetailScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _selectedTab = 0;
  bool _isFavorite = false;

  void _launchCaller() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '1234567890');
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint("Could not launch caller: $e");
    }
  }

  void _launchMsg() async {
    final Uri launchUri = Uri(scheme: 'sms', path: '1234567890');
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      debugPrint("Could not launch msg: $e");
    }
  }

  void _launchMaps() async {
    final query = Uri.encodeComponent(widget.property.address);
    final googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Could not launch maps: $e");
    }
  }

  void _shareProperty() {
    Share.share('Check out this property: ${widget.property.title} in ${widget.property.address}. Price: ${widget.property.price}');
  }

  void _handleBookNow() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Booking Request Sent!"),
            content: Text("We have received your request to visit on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}. An agent will contact you shortly."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imageSection(),
                    _actionButtons(),
                    _tabs(),
                    _contentSection(),
                  ],
                ),
              ),
            ),
            _bookButton(context),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------
  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Text('← Back', style: TextStyle(fontSize: 16)),
          ),
          const Text(
            'Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: _shareProperty,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- IMAGE ----------------
  Widget _imageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.property.imageUrl,
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.photo, size: 16),
                  SizedBox(width: 4),
                  Text('24'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ACTION BUTTONS ----------------
  Widget _actionButtons() {
    final actions = [
      {'icon': Icons.call, 'label': 'Call', 'action': _launchCaller},
      {'icon': Icons.message, 'label': 'Message', 'action': _launchMsg},
      {'icon': Icons.directions, 'label': 'Direction', 'action': _launchMaps},
      {'icon': Icons.share, 'label': 'Share', 'action': _shareProperty},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: actions.map((a) {
          return Expanded(
            child: GestureDetector(
              onTap: a['action'] as VoidCallback,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(a['icon'] as IconData),
                    const SizedBox(height: 6),
                    Text(
                      a['label'] as String,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------- TABS ----------------
  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _tabItem('Overview', 0),
          _tabItem('Features', 1),
          _tabItem('House Value', 2),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: active
                ? [const BoxShadow(color: Colors.black12, blurRadius: 6)]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: active ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- CONTENT ----------------
  Widget _contentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE & PRICE (Always visible)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.property.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.property.price,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // LOCATION
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.property.address,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // DYNAMIC CONTENT BASED ON TAB
          if (_selectedTab == 0) _overviewContent(),
          if (_selectedTab == 1) _featuresContent(),
          if (_selectedTab == 2) _houseValueContent(),

        ],
      ),
    );
  }

  Widget _overviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // INFO ROW
        Row(
          children: [
            _info(Icons.bed, '${widget.property.bedrooms} Beds'),
            const SizedBox(width: 12),
            _info(Icons.bathtub, '${widget.property.bathrooms} Bath'),
            const SizedBox(width: 12),
            _info(Icons.square_foot, '${widget.property.areaSqft} sqft'),
          ],
        ),

        const SizedBox(height: 16),

        // DESCRIPTION
        const Text(
          'Overview',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Cozy and homey with the most affordable price available in the marketplace. '
              'Beautifully designed with modern interiors and premium facilities. '
              'Located in a prime area with easy access to all amenities.',
          style: const TextStyle(color: Colors.grey, height: 1.5),
        ),

        const SizedBox(height: 20),

        // RATING
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                const SizedBox(width: 6),
                Text(
                  '${widget.property.rating} · 2K Reviews',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text('Top rated ⌄'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // REVIEW CARD
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Text(
            '"We were only sad not to stay longer. We hope to be back again!"',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  Widget _featuresContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text(
            'Facilities & Amenities',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: const [
              _Facility(icon: Icons.local_parking, label: "Parking"),
              _Facility(icon: Icons.restaurant, label: "Kitchen"),
              _Facility(icon: Icons.pool, label: "Pool"),
              _Facility(icon: Icons.fitness_center, label: "Gym"),
              _Facility(icon: Icons.wifi, label: "Wi-Fi"),
              _Facility(icon: Icons.local_laundry_service, label: "Laundry"),
              _Facility(icon: Icons.park, label: "Garden"),
              _Facility(icon: Icons.security, label: "Security"),
            ],
          ),
      ],
    );
  }

  Widget _houseValueContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
           _valueRow("Price", widget.property.price),
           const Divider(),
           _valueRow("Tax (Est.)", "₹12,000/yr"),
           const Divider(),
           _valueRow("HOA Token", "₹2,000/mo"),
           const Divider(),
           _valueRow("Price/Sqft", "₹${(24000/widget.property.areaSqft).round()}"),
        ],
      ),
    );
  }
  
  Widget _valueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  // ---------------- BOOK BUTTON ----------------
  Widget _bookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: _handleBookNow,
          child: const Text(
            'Book Now',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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
        Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }
}

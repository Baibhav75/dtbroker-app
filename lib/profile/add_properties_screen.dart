import 'package:dtbroker/profile/my_posted_properties_page.dart';
import 'package:flutter/material.dart';

class AddPropertiesScreen extends StatefulWidget {
  const AddPropertiesScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertiesScreen> createState() =>
      _AddPropertiesScreenState();
}

class _AddPropertiesScreenState
    extends State<AddPropertiesScreen> {

  int currentStep = 1;
  String selectedCategory = "Sale";
  bool hideNumber = false;

  final List<String> propertyTypes = [
    "Apartment",
    "Villa",
    "Plot",
    "Office",
  ];

  final List<String> bhkList = [
    "1 BHK",
    "2 BHK",
    "3 BHK",
    "4 BHK"
  ];


  final List<String> statesList = [
    "Uttar Pradesh",
    "Madhya Pradesh",
    "Delhi",
    "Rajasthan",
    "Bihar",
    "Gujarat",
    "Maharashtra",
    "Punjab",
    "Haryana",
  ];

  String? selectedState;

  String? selectedType;
  String? selectedBhk;

  void initState() {
    super.initState();
    selectedState ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Property"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ================= STEP BAR =================
            _stepBar(),

            const SizedBox(height: 20),

            // ================= BASIC DETAILS =================
            _card(
              title: "Basic Details",
              icon: Icons.home,
              child: Column(
                children: [

                  _textField("Property Title"),

                  const SizedBox(height: 12),

                  _dropdown(
                    label: "Property Type",
                    value: selectedType,
                    items: propertyTypes,
                    onChanged: (val) {
                      setState(() {
                        selectedType = val;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  _categoryToggle(),

                  const SizedBox(height: 12),

                  _textField("Price", prefix: "₹"),

                  const SizedBox(height: 12),

                  _textField("Area (Sqft)"),

                  const SizedBox(height: 12),

                  _dropdown(
                    label: "BHK",
                    value: selectedBhk,
                    items: bhkList,
                    onChanged: (val) {
                      setState(() {
                        selectedBhk = val;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= LOCATION =================
            _card(
              title: "Location Details",
              icon: Icons.location_on,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DropdownButtonFormField<String>(
                      value: selectedState,
                      decoration: const InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(),
                      ),
                      items: statesList.map((state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;

                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _textField("City"),
                  const SizedBox(height: 12),
                  _textField("Locality"),
                  const SizedBox(height: 12),
                  _textField("Landmark (Optional)"),
                  const SizedBox(height: 12),
                  _textField("Pincode"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= MEDIA =================
            _card(
              title: "Upload Photos & Video",
              icon: Icons.photo,
              child: Row(
                children: [
                  _mediaBox("+ Add Photos"),
                  const SizedBox(width: 10),
                  _mediaBox("Upload Video"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= DESCRIPTION =================
            _card(
              title: "Description & Amenities",
              icon: Icons.description,
              child: Column(
                children: [
                  _textField("Property Description",
                      maxLines: 3),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: [
                      _amenityChip("Parking"),
                      _amenityChip("Lift"),
                      _amenityChip("CCTV"),
                      _amenityChip("Security"),
                      _amenityChip("Garden"),
                      _amenityChip("Gym"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= CONTACT =================
            _card(
              title: "Contact Details",
              icon: Icons.person,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("Pawan Kumar",
                          style: TextStyle(
                              fontWeight:
                              FontWeight.bold)),
                      Text("+91 9876543211"),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Hide Number"),
                      Switch(
                        value: hideNumber,
                        onChanged: (val) {
                          setState(() {
                            hideNumber = val;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  final newProperty = {
                    "id": "PR-${DateTime.now().millisecondsSinceEpoch}",
                    "title": "New Property",
                    "location": selectedState ?? "Unknown",
                    "price": "₹50,00,000",
                    "status": "Active",
                    "date": "${DateTime.now().day} "
                        "${DateTime.now().month} "
                        "${DateTime.now().year}",
                  };

                  Navigator.pop(context, newProperty);  // 👈 IMPORTANT
                },
                child: const Text("Submit Property"),
              ),
            ),


            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= STEP BAR =================
  Widget _stepBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _stepItem("1. Details", true),
        _stepItem("2. Location", false),
        _stepItem("3. Media", false),
        _stepItem("4. Review", false),
      ],
    );
  }

  Widget _stepItem(String text, bool active) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color:
        active ? Colors.blue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  // ================= CARD =================
  Widget _card({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 6),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  // ================= TEXT FIELD =================
  Widget _textField(String label,
      {String? prefix, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ================= DROPDOWN =================
  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ))
          .toList(),
      onChanged: onChanged,
    );
  }

  // ================= CATEGORY TOGGLE =================
  Widget _categoryToggle() {
    return Row(
      children: [
        const Text("Category"),
        const SizedBox(width: 20),
        ChoiceChip(
          label: const Text("Sale"),
          selected: selectedCategory == "Sale",
          onSelected: (_) {
            setState(() {
              selectedCategory = "Sale";
            });
          },
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text("Rent"),
          selected: selectedCategory == "Rent",
          onSelected: (_) {
            setState(() {
              selectedCategory = "Rent";
            });
          },
        ),
      ],
    );
  }

  // ================= MEDIA BOX =================
  Widget _mediaBox(String text) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  // ================= AMENITY CHIP =================
  Widget _amenityChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: false,
      onSelected: (_) {},
    );
  }
}

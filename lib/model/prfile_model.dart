class ProfileUpdateRequestModel {
  int id;
  String name;
  String email;
  String mobileNumber;
  String password;
  String state;
  String city;
  String address;
  String pincode;

  ProfileUpdateRequestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.state,
    required this.city,
    required this.address,
    required this.pincode,
  });

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "Email": email,
      "MobileNumber": mobileNumber,
      if (password.isNotEmpty) "Password": password,
      "State": state,
      "City": city,
      "Address": address,
      "Pincode": pincode,
    };
  }

  }


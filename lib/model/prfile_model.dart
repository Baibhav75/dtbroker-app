// class ProfileUpdateRequestModel {
//   int id;
//   String name;
//   String email;
//   String mobileNumber;
//   String password;
//   String state;
//   String city;
//   String address;
//   String pincode;
//
//   ProfileUpdateRequestModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobileNumber,
//     required this.password,
//     required this.state,
//     required this.city,
//     required this.address,
//     required this.pincode,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "Id": id,
//       "Name": name,
//       "Email": email,
//       "MobileNumber": mobileNumber,
//       if (password.isNotEmpty) "Password": password,
//       "State": state,
//       "City": city,
//       "Address": address,
//       "Pincode": pincode,
//     };
//   }
//
//   }
//


class ProfileModel {
  final bool status;
  final String message;
  final ProfileData? data;

  ProfileModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json["Status"] ?? false,
      message: json["Message"] ?? "",
      data: json["Data"] != null
          ? ProfileData.fromJson(json["Data"])
          : null,
    );
  }
}

class ProfileData {
  final String uniqueId;
  final String name;
  final String email;
  final String mobileNumber;
  final String state;
  final String city;
  final String address;
  final String pincode;
  final String profile;

  ProfileData({
    required this.uniqueId,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.state,
    required this.city,
    required this.address,
    required this.pincode,
    required this.profile,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      uniqueId: json["UniqueId"] ?? "",
      name: json["Name"] ?? "",
      email: json["Email"] ?? "",
      mobileNumber: json["MobileNumber"] ?? "",
      state: json["State"] ?? "",
      city: json["City"] ?? "",
      address: json["Address"] ?? "",
      pincode: json["Pincode"] ?? "",
      profile: json["Profile"] ?? "",
    );
  }
}
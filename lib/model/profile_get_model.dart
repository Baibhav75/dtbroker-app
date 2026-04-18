// class ProfileModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   ProfileModel({this.status, this.message, this.data});
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'];
//     message = json['Message'];
//     data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     data['Message'] = this.message;
//     if (this.data != null) {
//       data['Data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? email;
//   String? mobile;
//   String? password;
//   String? state;
//   String? city;
//   String? address;
//   String? pincode;
//
//   Data(
//       {this.id,
//         this.name,
//         this.email,
//         this.mobile,
//         this.password,
//         this.state,
//         this.city,
//         this.address,
//         this.pincode});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     email = json['Email'];
//     mobile = json['Mobile'];
//     password = json['Password'];
//     state = json['State'];
//     city = json['City'];
//     address = json['Address'];
//     pincode = json['Pincode'];
//   }
//
//   get profile => null;
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['Email'] = this.email;
//     data['Mobile'] = this.mobile;
//     data['Password'] = this.password;
//     data['State'] = this.state;
//     data['City'] = this.city;
//     data['Address'] = this.address;
//     data['Pincode'] = this.pincode;
//     return data;
//   }
// }

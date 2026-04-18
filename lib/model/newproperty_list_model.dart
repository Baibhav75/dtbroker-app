class NewPropertyListModel {
  bool? status;
  String? message;
  List<Data>? data;

  NewPropertyListModel({this.status, this.message, this.data});

  NewPropertyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? propertyId;
  String? propertyTitle;
  String? propertyDescription;
  String? propertyType;
  String? status;
  double? price;
  double? area;
  int? rooms;
  int? bathrooms;
  int? propertyAge;
  String? propertyFeatures;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  double? latitude;
  double? longitude;
  String? contactName;
  String? username;
  String? email;
  String? phone;
  String? flatBHK;
  String? propertyImage1;
  String? video;
  String? createdDate;

  Data(
      {this.propertyId,
        this.propertyTitle,
        this.propertyDescription,
        this.propertyType,
        this.status,
        this.price,
        this.area,
        this.rooms,
        this.bathrooms,
        this.propertyAge,
        this.propertyFeatures,
        this.city,
        this.state,
        this.country,
        this.pinCode,
        this.latitude,
        this.longitude,
        this.contactName,
        this.username,
        this.email,
        this.phone,
        this.flatBHK,
        this.propertyImage1,
        this.video,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    propertyId = json['PropertyId'];
    propertyTitle = json['PropertyTitle'];
    propertyDescription = json['PropertyDescription'];
    propertyType = json['PropertyType'];
    status = json['Status'];
    price = json['Price'];
    area = json['Area'];
    rooms = json['Rooms'];
    bathrooms = json['Bathrooms'];
    propertyAge = json['PropertyAge'];
    propertyFeatures = json['PropertyFeatures'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    pinCode = json['PinCode'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    contactName = json['ContactName'];
    username = json['Username'];
    email = json['Email'];
    phone = json['Phone'];
    flatBHK = json['FlatBHK'];
    propertyImage1 = json['PropertyImage1'];
    video = json['Video'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PropertyId'] = this.propertyId;
    data['PropertyTitle'] = this.propertyTitle;
    data['PropertyDescription'] = this.propertyDescription;
    data['PropertyType'] = this.propertyType;
    data['Status'] = this.status;
    data['Price'] = this.price;
    data['Area'] = this.area;
    data['Rooms'] = this.rooms;
    data['Bathrooms'] = this.bathrooms;
    data['PropertyAge'] = this.propertyAge;
    data['PropertyFeatures'] = this.propertyFeatures;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['PinCode'] = this.pinCode;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['ContactName'] = this.contactName;
    data['Username'] = this.username;
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    data['FlatBHK'] = this.flatBHK;
    data['PropertyImage1'] = this.propertyImage1;
    data['Video'] = this.video;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}
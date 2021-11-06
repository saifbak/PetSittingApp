class User {
  int? id;
  String? username;
  late String name;
  late String email;
  String? password;
  int? roleId;
  String? address;
  String? phone;
  double? hourlyRate;
  String? profileImg;
  String? description;
  int? overallRating;
  String? ratingFormatted;
  List<dynamic> reviews = [];
  String? licenseImg;
  int? isActive;
  dynamic? location;

  User(
      {this.id,
      required this.name,
      this.username,
      required this.email,
      this.password,
      this.address,
      this.phone,
      this.hourlyRate,
      this.roleId,
      this.description,
      this.profileImg,
      this.licenseImg,
      this.location,
      this.isActive});

  dynamic toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['description'] = this.description;
    data['role_id'] = this.roleId;
    data['profile_img'] = this.profileImg;
    data['license_img'] = this.licenseImg;
    data['location'] = this.location;
    data['is_active'] = this.isActive;
    return data;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    description = json['description'];
    profileImg = json['profile_img'];
    licenseImg = json['license_img'];
    phone = json['phone'];
    location = json['location'];
    address = json['address'];
    roleId = json['role_id'];
    overallRating = json['overall_rating'];
    ratingFormatted = json['rating_formatted'];
    reviews = json['reviews'] ?? [];
    isActive = json['is_active'];
  }
}

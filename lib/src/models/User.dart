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
      this.profileImg});

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
    return data;
  }
}

class User {
  int? id;
  String? username;
  late String name;
  late String email;
  String? password;
  String? address;
  String? phone;
  double? hourlyRate;

  User({
    this.id,
    required this.name,
    this.username,
    required this.email,
    this.password,
    this.address,
    this.phone,
    this.hourlyRate,
  });

  dynamic toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['hourly_rate'] = this.hourlyRate;
    return data;
  }
}

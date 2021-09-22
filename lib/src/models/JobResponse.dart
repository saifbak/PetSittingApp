class JobResp {
  late int id;
  late int petsitterId;
  late int jobId;
  late String name;
  int? roleId;
  String? username;
  String? email;
  String? phone;
  String? address;
  String? startDate;
  String? endDate;
  String? description;
  String? status;
  String? hourlyRate;
  Map<String, dynamic>? owner;

  JobResp(
      {required this.id,
      required this.petsitterId,
      required this.jobId,
      required this.name,
      this.roleId,
      this.username,
      this.email,
      this.phone,
      this.address,
      this.startDate,
      this.endDate,
      this.description,
      this.hourlyRate,
      this.status});

  JobResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petsitterId = json['petowner_id'];
    jobId = json['job_id'];
    name = json['name'];
    roleId = json['role_id'];
    email = json['username'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    status = json['status'];
    owner = json['owner'];
    hourlyRate = json['hourly_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petsitter_id'] = this.petsitterId;
    data['petowner_id'] = this.jobId;
    data['name'] = this.name;
    data['role_id'] = this.roleId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['hourly_rate'] = this.hourlyRate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}

class Job {
  late int id;
  late int petownerId;
  late String petName;
  String? location;
  int? age;
  String? weight;
  String? fromDate;
  String? toDate;
  String? breed;
  String? description;
  String? status;
  String? jobStatus;
  String? period;
  String? publicImage;
  Map<String, dynamic>? owner;
  Map<String, dynamic>? assigned;
  List<Map<String, dynamic>>? proposals;

  Job(
      {required this.id,
      required this.petownerId,
      required this.petName,
      this.location,
      this.age,
      this.weight,
      this.fromDate,
      this.toDate,
      this.breed,
      this.description,
      this.jobStatus,
      this.status});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petownerId = json['petowner_id'];
    petName = json['pet_name'];
    location = json['location'];
    age = json['age'];
    weight = json['weight'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    breed = json['breed'];
    description = json['description'];
    status = json['status'];
    jobStatus = json['job_status'];
    period = json['period'];
    owner = json['owner'];
    assigned = json['assigned'];
    proposals = json['proposals'];
    publicImage = json['public_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petowner_id'] = this.petownerId;
    data['pet_name'] = this.petName;
    data['location'] = this.location;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['breed'] = this.breed;
    data['description'] = this.description;
    data['status'] = this.status;
    data['public_image'] = this.publicImage;
    return data;
  }
}

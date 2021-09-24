class Review {
  late int id;
  late int petownerId;
  late int petsitterId;
  late String name;
  int? jobid;
  int? question1;
  int? question2;
  int? question3;
  String? comment;
  int? overallRating;
  Map<String, dynamic>? owner;

  Review({
    required this.id,
    required this.jobid,
    required this.petownerId,
    required this.petsitterId,
    required this.name,
    this.question1,
    this.question2,
    this.question3,
    this.comment,
    this.overallRating,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobid = json['job_id'];
    petownerId = json['petowner_id'];
    petsitterId = json['petsitter_id'];
    name = json['name'];
    question1 = json['question1'];
    question2 = json['question2'];
    question3 = json['question3'];
    comment = json['comment'];
    overallRating = json['overall_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petowner_id'] = this.petownerId;
    data['petowner_id'] = this.petsitterId;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['question1'] = this.question1;
    data['question2'] = this.question2;
    data['question3'] = this.question3;
    data['overall_rating'] = this.overallRating;
    return data;
  }
}

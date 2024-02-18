class StudentModal {
  String email;
  String enrollmentNo;
  String name;
  String hostel;
  int roomNo;
  Map profile;

  StudentModal({
    required this.email,
    required this.enrollmentNo,
    required this.name,
    required this.profile,
    required this.hostel,
    required this.roomNo,
  });

  StudentModal.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email']! as String,
            enrollmentNo: json['enrollmentNo']! as String,
            name: json['name']! as String,
            profile: Map<String, dynamic>.from(json['profile'] ?? {}),
            hostel: json['hostel']! as String,
            roomNo: json['roomNo']! as int);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'enrollmentNo': enrollmentNo,
      'profile': profile,
      'hostel': hostel,
      'roomNo': roomNo,
    };
  }
}

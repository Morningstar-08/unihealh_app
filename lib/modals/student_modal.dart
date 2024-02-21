class StudentModal {
  String email;
  String enrollmentNo;
  String name;
  String hostel;
  int roomNo;
  Map profile;
  String userType;

  StudentModal({
    required this.email,
    required this.enrollmentNo,
    required this.name,
    required this.profile,
    required this.hostel,
    required this.roomNo,
    required this.userType,
  });

  StudentModal.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email']! as String,
            enrollmentNo: json['enrollmentNo']! as String,
            name: json['name']! as String,
            profile: Map<String, dynamic>.from(json['profile'] ?? {}),
            hostel: json['hostel']! as String,
            roomNo: json['roomNo']! as int,
            userType: json['userType']! as String);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'enrollmentNo': enrollmentNo,
      'profile': profile,
      'hostel': hostel,
      'roomNo': roomNo,
      'userType': userType,
    };
  }
}

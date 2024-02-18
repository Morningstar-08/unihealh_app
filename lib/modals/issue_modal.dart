class IssueModal {
  DateTime timestamp;
  String issueDesc;
  String issueTitle;
  bool status;
  String studentId;

  IssueModal({
    required this.timestamp,
    required this.issueDesc,
    required this.issueTitle,
    required this.status,
    required this.studentId,
  });

  IssueModal.fromJson(Map<String, dynamic> json)
      : this(
            timestamp: json['TIMESTAMP']! as DateTime,
            issueDesc: json['issueDesc']! as String,
            issueTitle: json['issueTitle']! as String,
            // profile: Map<String, dynamic>.from(json['profile'] ?? {}),
            status: json['status']! as bool,
            studentId: json['studentId']! as String);

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'issueDesc': issueDesc,
      'issueTitle': issueTitle,
      'status': status,
      'studentId': studentId
    };
  }
}

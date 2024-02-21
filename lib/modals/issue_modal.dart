import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class IssueModal {
  Timestamp timestamp;
  String issueDesc;
  String issueTitle;
  bool status;
  String studentId;
  Array doctorReply;

  IssueModal({
    required this.timestamp,
    required this.issueDesc,
    required this.issueTitle,
    required this.status,
    required this.studentId,
    required this.doctorReply,
  });

  IssueModal.fromJson(Map<String, dynamic> json)
      : this(
            timestamp: json['TIMESTAMP']! as Timestamp,
            issueDesc: json['issueDesc']! as String,
            issueTitle: json['issueTitle']! as String,
            // profile: Map<String, dynamic>.from(json['profile'] ?? {}),
            status: json['status']! as bool,
            studentId: json['studentId']! as String,
            doctorReply: json['doctorReply']! as Array);

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

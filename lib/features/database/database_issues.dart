import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/modals/issue_modal.dart';

const String ISSUE_COLLECTION_REF = 'issues';

class DatabaseServiceIssues {
  Future addIssue(IssueModal issueMap, String id) async {
    return await FirebaseFirestore.instance
        .collection(ISSUE_COLLECTION_REF)
        .doc(id)
        .set(issueMap.toJson());
  }

  Future<QuerySnapshot?> getIssueDetails() async {
    String? uid = FirebaseAuth.instance.currentUser!.email;
    return FirebaseFirestore.instance
        .collection(ISSUE_COLLECTION_REF)
        .where("studentid", isEqualTo: uid)
        .get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

const String ISSUE_COLLECTION_REF = 'issues';

class DatabaseServiceIssues {
  Future addIssue(data, String id) async {
    return await FirebaseFirestore.instance
        .collection(ISSUE_COLLECTION_REF)
        .doc(id)
        .set(data);
  }

  // Future<Stream<QuerySnapshot>> getIssuesAll() async {
  //   return await FirebaseFirestore.instance.collection(ISSUE_COLLECTION_REF).;
  // }
}

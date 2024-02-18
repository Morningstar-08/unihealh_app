import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care_app/modals/student_modal.dart';

const String STUDENT_COLLECTION_REF = 'students';

class DatabaseService {
  Future addStudent(StudentModal studentMap, String id) async {
    return await FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .doc(id)
        .set(studentMap.toJson());
  }

  getStudentsDetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .doc(uid)
        .snapshots();
  }
}

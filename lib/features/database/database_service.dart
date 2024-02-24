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

  Future<String?> getUserType() async {
    String? uid = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where("email", isEqualTo: uid)
        .get();

    QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where("email", isEqualTo: uid)
        .get();

    if (studentSnapshot.docs.isNotEmpty) {
      return studentSnapshot.docs[0]["userType"];
    } else if (doctorSnapshot.docs.isNotEmpty) {
      return doctorSnapshot.docs[0]["userType"];
    } else {
      return null;
    }
  }

  Future<QuerySnapshot> getStudents() async {
    String? uid = FirebaseAuth.instance.currentUser!.email;
    return FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .where("email", isEqualTo: uid)
        .get();
  }

  Future<QuerySnapshot> getStudentDetails(String uid) async {
    return FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .where("email", isEqualTo: uid)
        .get();
  }
}

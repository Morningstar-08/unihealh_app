import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care_app/modals/student_modal.dart';

const String STUDENT_COLLECTION_REF = 'students';

class DatabaseService {
  Future addStudent(StudentModal studentMap, String id) async {
    return await FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .doc(id)
        .set(studentMap.toJson());
  }

  Future<QuerySnapshot> getStudentsDetails(String email) async {
    return await FirebaseFirestore.instance
        .collection(STUDENT_COLLECTION_REF)
        .where("email", isEqualTo: email)
        .get();
  }
}

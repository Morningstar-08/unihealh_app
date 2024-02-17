import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpwithEmailAndPassword(
      String email,
      String password,
      String enrollmentNumber,
      String studentName,
      String hostelRoomNumber,
      String dob,
      String bloodGroup,
      String height,
      String weight,
      String allergies,
      String medicalRecord) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occurrred while signing up");
    }
    return null;
  }

  Future<User?> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("ERRORR");
    }
    return null;
  }
}

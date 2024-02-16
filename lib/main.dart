import 'package:flutter/material.dart';
import 'package:health_care_app/pages/splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp().catchError((error) {
  //   print("Error initializing Firebase: $error");
  // });
  runApp(const MyApp(
    key: null,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({required key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:health_care_app/pages/login_page.dart";
import 'package:health_care_app/features/database/database_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<QuerySnapshot> _studentFuture;
  // final String profileImage = 'assets/toril.jpg'; // Use local asset path

  @override
  void initState() {
    _studentFuture = DatabaseService().getStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _studentFuture,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs[0];

              String name = data['name'] ?? '';
              String email = data['email'] ?? '';
              String dob = data['profile']['dob'] ?? '';
              String hostelName = data['hostel'] ?? '';
              String height = data['profile']['height']?.toString() ?? '';
              String weight = data['profile']['weight']?.toString() ?? '';
              String bloodGroup = data['profile']['bloodGroup'] ?? '';
              String allergies = data['profile']['allergies'] ?? '';
              String medicalHistory = data['profile']['medicalRecord'] ?? '';
              String sex = data['profile']['sex'] ?? '';
              int hostelRoom = data['roomNo'] ?? '';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/dummy_profile.jpg'),
                        radius: 65.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Info Section
                          const Text(
                            'Personal Info',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: Colors.grey, thickness: 1.0),
                          ProfileList(text: email, icon: Icons.email_outlined),
                          ProfileList(text: dob, icon: Icons.cake_outlined),
                          ProfileList(
                              text: "$hostelName - $hostelRoom",
                              icon: Icons.home_outlined),
                          // Medical Info Section
                          const SizedBox(height: 10.0),
                          const Text(
                            'Medical Info',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: Colors.grey, thickness: 1.0),
                          ProfileList(text: sex, icon: Icons.person_outline),
                          ProfileList(
                              text: "$height cm", icon: Icons.height_outlined),
                          ProfileList(
                              text: "$weight kg",
                              icon: Icons.fitness_center_outlined),
                          ProfileList(
                              text: bloodGroup, icon: Icons.bloodtype_outlined),
                          ProfileList(
                            text: allergies,
                            icon: Icons.health_and_safety_outlined,
                            isSubtitle: true,
                            subtitle: 'Allergies',
                          ),
                          ProfileList(
                            text: medicalHistory,
                            icon: Icons.history_outlined,
                            isSubtitle: true,
                            subtitle: 'Medical History',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(title: "Login Page"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          }
        },
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
    required this.text,
    required this.icon,
    this.isSubtitle = false,
    this.subtitle = '',
  });

  final String text;
  final IconData icon;
  final bool isSubtitle;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0), // Responsive padding
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(text),
      subtitle: isSubtitle ? Text(subtitle) : null,
    );
  }
}

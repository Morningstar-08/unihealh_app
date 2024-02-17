import "package:flutter/material.dart";
import "package:health_care_app/pages/login_page.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String profileImage =
      'assets/toril.jpg'; // Use local asset path instead of external URL
  final String name = 'Swastik';

  // Replace placeholder data with actual user information from your data source
  final String email = 'swastik@example.com';
  final String dob = '1999-01-01';
  final String height = '175 cm';
  final String weight = '70 kg';
  final String bloodGroup = 'O+';
  final String allergies = 'Dust mites, Peanuts';
  final String medicalHistory = 'None reported';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 164, 144, 220),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(title: 'login_page'),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
            // Use SingleChildScrollView for scrollable content
            child: Column(children: [
          Container(
            color: const Color.fromARGB(255, 164, 144, 220),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(profileImage),
                    radius: 60.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                ListTile(
                  leading: const Icon(
                    Icons.email_outlined,
                    color: Colors.deepPurpleAccent,
                  ),
                  title: Text(email),
                  //  subtitle: const Text('Email Address'),
                ),
                // Date of Birth
                ListTile(
                  leading: const Icon(Icons.cake_outlined),
                  title: Text(dob),
                  //subtitle: const Text('Date of Birth'),
                ),
                // Height
                ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: Text(height),
                  subtitle: const Text('Height'),
                ),
                // Weight
                ListTile(
                  leading: const Icon(Icons.balance),
                  title: Text(weight),
                  subtitle: const Text('Weight'),
                ),
                // // Blood Group
                ListTile(
                  leading: const Icon(Icons.bloodtype),
                  title: Text(bloodGroup),
                  subtitle: const Text('Blood Group'),
                ),
                // Allergies
                ListTile(
                  leading: const Icon(Icons.warning),
                  title: Text(allergies),
                  subtitle: const Text('Allergies'),
                ),
                // Medical History
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(medicalHistory),
                  subtitle: const Text('Medical History'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ])));
  }
}

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
  final String name = 'Toril Jain';

  // Replace placeholder data with actual user information from your data source
  final String email = 'toril@example.com';
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
          // title: const Text('Back'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
                ProfileList(text: email, icon: Icons.email_outlined),
                ProfileList(text: dob, icon: Icons.cake_outlined),
                ProfileList(text: height, icon: Icons.height_outlined),
                ProfileList(text: weight, icon: Icons.fitness_center_outlined),
                ProfileList(text: bloodGroup, icon: Icons.bloodtype_outlined),
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
                    subtitle: 'Medical History'),
              ],
            ),
          ),
          // const SizedBox(height: 20.0),
        ])));
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList(
      {super.key,
      required this.text,
      required this.icon,
      this.isSubtitle = false,
      this.subtitle = ''});

  final String text;
  final IconData icon;
  final bool isSubtitle;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(text),
      subtitle: isSubtitle ? Text(subtitle) : null,
      //  subtitle: const Text('Email Address'),
    );
  }
}

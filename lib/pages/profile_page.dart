import "package:flutter/material.dart";
import "package:health_care_app/pages/login_page.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String profileImage = 'assets/toril.jpg'; // Use local asset path
  final String name = 'Toril Jain';

  // Replace placeholder data with actual user information from your data source
  final String email = 'toril@example.com';
  final String dob = '1999-01-01';
  final String hostelNumber = 'H203';
  final String height = '175 cm';
  final String weight = '70 kg';
  final String bloodGroup = 'O+';
  final String allergies = 'Dust mites, Peanuts';
  final String medicalHistory = 'None reported';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                  radius: 65.0,
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
              const SizedBox(height: 10.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle edit profile navigation
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                ProfileList(text: hostelNumber, icon: Icons.home_outlined),
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
                  subtitle: 'Medical History',
                ),
              ],
            ),
          ),
        ]),
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

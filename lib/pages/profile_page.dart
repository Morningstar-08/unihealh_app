import "package:flutter/material.dart";
import "package:health_care_app/pages/login_page.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});
  // static const routeName = '/profile'
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.deepPurple[100],
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          // title: const Text('Back'),
          centerTitle: true,
          title: Text('Pronbhjfile',
              style: Theme.of(context).textTheme.headlineMedium),
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
        body: const SingleChildScrollView(
            padding: EdgeInsets.all(20),
            // margin: EdgeInsets.only(left: 20, bottom: 150, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('lib\\images\\profileImg.jpg'),
                            radius: 60,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Student Name: Swastik',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Age: 19',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hostel Room Number: 1234',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Blood Group: B+',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Height: 5\'10"',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Weight: 56 kg',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Allergies: None',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Medical Records: None',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

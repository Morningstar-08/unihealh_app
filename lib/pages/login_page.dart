import 'package:flutter/material.dart';
import 'package:health_care_app/pages/dashboard_page.dart';
import 'package:health_care_app/pages/profile_page.dart';
import 'package:health_care_app/pages/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:health_care_app/features/authentication/firebase_authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  signIn() async {
    String email = _usernameController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInwithEmailAndPassword(email, password);

    if (user != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
    } else {
      print("Error signing in");
    }
  }
  // void _signIn() async {
  //   String email = _usernameController.text;
  //   String password = _passwordController.text;

  //   User? user = await _auth.signInwithEmailAndPassword(email, password);
  //   if (user != null) {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const DashboardPage()));
  //   } else {
  //     print("Error signing in");
  //   }
  // }

  // _signIn() async {
  //   String email = _usernameController.text;
  //   String password = _passwordController.text;

  //   if (email == "" && password == "") {
  //     print("Empty fields");
  //   } else {
  //     UserCredential? userCredential;
  //     try {
  //       userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => const Profile()));
  //     } on FirebaseAuthException catch (ex) {
  //       print(ex.message);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          //key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: _usernameController,
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Please enter a valid email",
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text("Remember me"),
                contentPadding: EdgeInsets.zero,
                value: true, // rememberValue,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (newValue) {
                  setState(() {
                    // rememberValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed:
                    // _signIn,
                    () {
                  signIn();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not registered yet?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignUp(title: 'signup_page'),
                        ),
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

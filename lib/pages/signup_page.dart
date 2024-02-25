import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_app/features/authentication/firebase_authservice.dart';
import 'package:health_care_app/features/database/database_service.dart';
import 'package:health_care_app/modals/student_modal.dart';
import 'package:health_care_app/pages/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.title});
  final String title;
  static const routeName = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _selectedBloodGroup = 'Blood Group';
  final List<String?> _bloodGroups = [
    'Blood Group',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  String? _selectedSex = 'Sex';
  final List<String?> _Sex = [
    'Sex',
    'Male',
    'Female',
    'Transgender',
    'Prefer not to say',
  ];

  final TextEditingController _enrollmentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _hostelNameController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicalRecordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _enrollmentController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    final FirebaseAuthService _auth = FirebaseAuthService();

    final String enrollmentNumber = _enrollmentController.text;
    final String studentName = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String sex = _sexController.text;
    final String hostelName = _hostelNameController.text;
    final String roomNumber = _roomNumberController.text;
    final String dob = _dobController.text;
    final String bloodGroup = _bloodGroupController.text;
    final String height = _heightController.text;
    final String weight = _weightController.text;
    final String allergies = _allergiesController.text;
    final String medicalRecord = _medicalRecordController.text;

    User? user = await _auth.signUpwithEmailAndPassword(
      email,
      password,
    );

    if (user != null) {
      StudentModal studentMap = StudentModal(
        email: email,
        enrollmentNo: enrollmentNumber,
        name: studentName,
        profile: {
          'allergies': allergies,
          'bloodGroup': bloodGroup,
          'dob': dob,
          'height': height,
          'medicalRecord': medicalRecord,
          'weight': weight,
          'sex': sex,
        },
        hostel: hostelName.toString(),
        roomNo: int.parse(roomNumber),
        userType: 'student',
      );
      await DatabaseService().addStudent(studentMap, enrollmentNumber);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage(title: 'login_page')));
    } else {
      AlertDialog(
        title: const Text('Error'),
        content: const Text('Error signing up'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginPage(title: 'login_page'),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Back'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(_createRoute());
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          autovalidateMode: _autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Student Registration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _enrollmentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enrollment Number',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Student Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a Password';
                    }
                    return null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Passwords Don\'t Match';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords Don\'t Match';
                    }
                    return null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String?>(
                  value: _selectedSex,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSex = newValue!;
                    });
                  },
                  items: _Sex.map((String? value) {
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: Text(value ?? 'Sex'),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Sex',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextFormField(
                          controller: _hostelNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Hostel Name',
                            prefixIcon: const Icon(Icons.home),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: _roomNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Room Number',
                            prefixIcon: const Icon(Icons.home),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _dobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dobController.text =
                            pickedDate.toIso8601String().split('T')[0];
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String?>(
                  value: _selectedBloodGroup,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBloodGroup = newValue!;
                    });
                  },
                  items: _bloodGroups.map((String? value) {
                    return DropdownMenuItem<String?>(
                      value: value,
                      child: Text(value ?? 'Blood Group'),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: 'Blood Group',
                    prefixIcon: const Icon(Icons.local_hospital),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _heightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Height (in cm)',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Weight (in kg)',
                    prefixIcon: const Icon(Icons.fitness_center),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _allergiesController,
                  decoration: InputDecoration(
                    hintText: 'Allergies',
                    prefixIcon: const Icon(Icons.health_and_safety),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _medicalRecordController,
                  decoration: InputDecoration(
                    hintText: 'Medical Record',
                    prefixIcon: const Icon(Icons.note),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });
                    _handleSignUp();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/features/database/database_issues.dart';
import 'package:health_care_app/pages/profile_page.dart';
import 'package:random_string/random_string.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? uid = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    // getonLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.person_2_outlined,
                    size: 26.0,
                  )))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(ISSUE_COLLECTION_REF)
              .where("studentid", isEqualTo: uid)
              .orderBy("createdOn", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot querySnapshot =
                        snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        //Navigate to medical record details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MedicalRecordDetails(issue: querySnapshot),
                          ),
                        );
                      },
                      child: Card(
                        color: Color.fromARGB(255, 236, 219, 252),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${querySnapshot['issueTitle']}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        //color:  ? Colors.green : Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      "${querySnapshot['createdOn']}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        //color:  ? Colors.green : Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              // Column(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         const Text('Ongoing: '),
                              //         Checkbox(
                              //           value: true,
                              //           onChanged: (value) {
                              //             setState(() {
                              //               //_isOngoing = value!;
                              //             });
                              //             // widget.record.ongoing = value!;
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //     Row(
                              //       children: [
                              //         const Text('Doctor Replied: '),
                              //         Checkbox(
                              //           value: true,
                              //           onChanged: (value) {
                              //             setState(
                              //               () {
                              //                 // _doctorReplied = value!;
                              //               },
                              //             );
                              //           },
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No Records Found , $snapshot",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                );
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => CreateMedicalRecordPage());
          // Navigate to create new record page
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MedicalRecordDetails extends StatefulWidget {
  final QueryDocumentSnapshot issue;
  const MedicalRecordDetails({super.key, required this.issue});

  @override
  State<MedicalRecordDetails> createState() => _MedicalRecordDetailsState();
}

class _MedicalRecordDetailsState extends State<MedicalRecordDetails> {
  String title = '';
  Timestamp createdOn = Timestamp.now();
  bool status = false;
  String description = "";
  List doctorReply = [];

  @override
  void initState() {
    title = widget.issue['issueTitle'] ?? '';
    status = widget.issue['status'] ?? false;
    description = widget.issue['issueDesc'] ?? '';
    doctorReply = widget.issue['doctorReply'] ?? (0);
    createdOn = widget.issue['createdOn'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title : $title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Symptoms: ${description}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Ongoing: ${status}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Doctor Replied: ${doctorReply}',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateMedicalRecordPage extends StatefulWidget {
  @override
  _CreateMedicalRecordPageState createState() =>
      _CreateMedicalRecordPageState();
}

class _CreateMedicalRecordPageState extends State<CreateMedicalRecordPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _symptomController = TextEditingController();
  String id = randomAlphaNumeric(10);

  // remove this and add the actual records list

  @override
  void dispose() {
    _titleController.dispose();
    _symptomController.dispose();
    super.dispose();
  }

  void issueAdd() async {
    String? uid = FirebaseAuth.instance.currentUser!.email;

    Map<String, dynamic> data = {
      'issueTitle': _titleController.text,
      'issueDesc': _symptomController.text,
      'status': true,
      'studentid': uid,
      'doctorReply': [],
      'createdOn': DateTime.now(),
    };
    await DatabaseServiceIssues().addIssue(data, id);
    print("success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Medical Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _symptomController,
              decoration: const InputDecoration(labelText: 'Symptoms'),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    issueAdd();
                    // Navigate back to DoctorDashboard
                    Navigator.pop(context);
                  },
                  child: const Text('Create Medical Record'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

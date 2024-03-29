import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/features/database/database_issues.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
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
              fontFamily: "Afacad",
              fontSize: 30,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(ISSUE_COLLECTION_REF)
              .where("studentid", isEqualTo: uid)
              .orderBy('status', descending: true)
              .orderBy("createdOn", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    // Ongoing Issues Section
                    if (snapshot.data!.docs.any((doc) => doc['status'] == true))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Text(
                              'Ongoing Issues',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...snapshot.data!.docs
                              .where((doc) => doc['status'] == true)
                              .map((querySnapshot) {
                            Timestamp timestamp = querySnapshot['createdOn'];
                            DateTime date = timestamp.toDate();
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(date);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicalRecordDetails(
                                        issue: querySnapshot),
                                  ),
                                );
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 127, 235, 131),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${querySnapshot['issueTitle']}",
                                              style: const TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Text(
                                                "Created On: $formattedDate",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 124, 123, 123),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),

                    // History Issues Section
                    if (snapshot.data!.docs
                        .any((doc) => doc['status'] == false))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Text(
                              'Medical History',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...snapshot.data!.docs
                              .where((doc) => doc['status'] == false)
                              .map((querySnapshot) {
                            Timestamp timestamp = querySnapshot['createdOn'];
                            DateTime date = timestamp.toDate();
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(date);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicalRecordDetails(
                                        issue: querySnapshot),
                                  ),
                                );
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 236, 219, 252),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${querySnapshot['issueTitle']}",
                                              style: const TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Text(
                                                "Created On: $formattedDate",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 124, 123, 123),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                  ],
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
          title: const Text("Details"),
          actions: [
            status
                ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        onTap: () {
                          widget.issue.reference.update({'status': false});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Close Issue",
                          style: TextStyle(fontSize: 18.0, color: Colors.red),
                        )))
                : Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 26.0,
                      ),
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title : $title',
                style: const TextStyle(fontSize: 28.0, fontFamily: 'Afacad'),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Issue Description : $description',
                style: const TextStyle(fontSize: 24.0, fontFamily: 'Afacad'),
              ),
              const SizedBox(height: 30.0),
              Text(
                'Doctor Reply : $doctorReply',
                style: const TextStyle(fontSize: 24.0, fontFamily: 'Afacad'),
              ),
            ],
          ),
        ));
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
        title: const Text(
          'Report Medical Issue',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
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
                  child: const Text('Report'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

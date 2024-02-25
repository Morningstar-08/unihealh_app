import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/features/database/database_issues.dart';
import 'package:health_care_app/features/database/database_service.dart';
import 'package:intl/intl.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
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
              fontFamily: 'Afacad',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 111, 89, 168)),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(ISSUE_COLLECTION_REF)
              .where("status", isEqualTo: true)
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
                    Timestamp timestamp = querySnapshot['createdOn'];
                    DateTime date = timestamp.toDate();
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(date);
                    bool onGoing = querySnapshot['status'];
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
                        color: onGoing
                            ? const Color.fromARGB(255, 127, 235, 131)
                            : const Color.fromARGB(169, 236, 219, 252),
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
                                        fontSize: 24.0,
                                        fontFamily: 'Afacad',
                                        fontWeight: FontWeight.w600,
                                        //color:  ? Colors.green : Colors.grey[600],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          "Created On: $formattedDate",
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 124, 123, 123),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
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
  String studentid = "";
  Future<QuerySnapshot>? studentDetails;
  String studentName = "";
  String enrollmentNo = "";
  String height = "";
  String weight = "";

  @override
  void initState() {
    title = widget.issue['issueTitle'] ?? '';
    status = widget.issue['status'] ?? false;
    description = widget.issue['issueDesc'] ?? '';
    doctorReply = widget.issue['doctorReply'] ?? (0);
    createdOn = widget.issue['createdOn'] ?? '';
    studentid = widget.issue['studentid'] ?? '';
    studentDetails = DatabaseService().getStudentDetails(studentid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(
              fontFamily: 'Afacad', fontSize: 28, fontWeight: FontWeight.w600),
        ),
        actions: [
          status
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        widget.issue.reference.update({'status': false});
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
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<QuerySnapshot>(
          future: studentDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var data = snapshot.data?.docs.first;
              studentName = data?['name'] ?? "";
              enrollmentNo = data?['enrollmentNo'] ?? "";
              height = data?['profile']['height'] ?? "";
              weight = data?['profile']['weight'] ?? "";
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            color: const Color.fromARGB(255, 250, 220, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Student Name: $studentName",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Afacad',
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Enrollment No: $enrollmentNo",
                                    style: const TextStyle(
                                        fontSize: 22, fontFamily: "Afacad"),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Height: $height",
                                    style: const TextStyle(
                                        fontSize: 22, fontFamily: 'Afacad'),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "Weight: $weight",
                                    style: const TextStyle(
                                        fontSize: 22, fontFamily: 'Afacad'),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Text(
                    'Title : $title',
                    style:
                        const TextStyle(fontSize: 26.0, fontFamily: 'Afacad'),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Issue Description : $description',
                    style:
                        const TextStyle(fontSize: 24.0, fontFamily: 'Afacad'),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Doctor Reply',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        doctorReply.add(value);
                      });
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

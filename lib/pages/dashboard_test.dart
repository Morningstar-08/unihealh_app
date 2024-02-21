import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/features/database/database_issues.dart';
import 'package:health_care_app/modals/issue_modal.dart';
import 'package:health_care_app/pages/login_page.dart';
import 'package:health_care_app/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginPage(title: 'login_page'),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _DashboardPageState extends State<DashboardPage> {
  //Future<QuerySnapshot?>? _issueFuture;
  Future<QuerySnapshot?> _issueFuture =
      DatabaseServiceIssues().getIssueDetails();
  getonLoad() async {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getonLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.person_2_outlined,
                    size: 26.0,
                  )))
        ],
      ),
      body: allIssueDetails(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new record page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateMedicalRecordPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget allIssueDetails() {
    return StreamBuilder<QuerySnapshot?>(
        stream: _issueFuture.asStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot querySnapshot =
                        snapshot.data!.docs[index];
                    print(querySnapshot);
                    print(querySnapshot['issueTitle']);
                    print(snapshot.data!.docs.length);
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "teri mummy ka title ${querySnapshot['issueTitle']}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        //color:  ? Colors.green : Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Ongoing: '),
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {
                                          setState(() {
                                            //_isOngoing = value!;
                                          });
                                          // widget.record.ongoing = value!;
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Doctor Replied: '),
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {
                                          setState(() {
                                            // _doctorReplied = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
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

  bool status = false;
  String description = "";
  List doctorReply = List.empty();

  @override
  void initState() {
    title = widget.issue['issueTitle'] ?? '';
    status = widget.issue['status'] ?? false;
    description = widget.issue['issueDesc'] ?? '';
    doctorReply = widget.issue['doctorReply'] ?? (0);
    // TODO: implement initState
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
  TextEditingController _dateController = TextEditingController();
  bool _ongoingValue = false;
  bool _doctorRepliedValue = false;

  // remove this and add the actual records list
  get records => null;

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
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
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text =
                        pickedDate.toIso8601String().split('T')[0];
                  });
                }
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text('Ongoing: '),
                Checkbox(
                  value: _ongoingValue,
                  onChanged: (value) {
                    setState(() {
                      _ongoingValue = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Doctor Replied: '),
                Checkbox(
                  value: _doctorRepliedValue,
                  onChanged: (value) {
                    setState(() {
                      _doctorRepliedValue = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Create a new medical record using the entered data

                // Add the new record to the list of records
                setState(() {
                  records.add();
                });

                // Clear text fields after adding record
                _titleController.clear();
                _dateController.clear();
                _ongoingValue = false;
                _doctorRepliedValue = false;

                // Navigate back to DoctorDashboard
                Navigator.pop(context);
              },
              child: const Text('Create Medical Record'),
            ),
          ],
        ),
      ),
    );
  }
}


//   final List<MedicalRecord> records = [
//     // Replace with actual medical record data
//     MedicalRecord(
//       title: 'Headache',
//       date: DateTime.now(),
//       ongoing: true,
//       doctorReplied: true,
//     ),
//     MedicalRecord(
//       title: 'Stomach Ache',
//       date: DateTime.now().subtract(const Duration(days: 5)),
//       ongoing: false,
//       doctorReplied: false,
//     ),
//   ];
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ProfilePage(),
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     Icons.person_2_outlined,
//                     size: 26.0,
//                   )))
//         ],
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(20.0),
//         itemCount: records.length,
//         itemBuilder: (context, index) => GestureDetector(
//           onTap: () {
//             // Navigate to medical record details page
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const MedicalRecordDetails(),
//               ),
//             );
//           },
//           child: MedicalRecordCard(record: records[index]),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to create new record page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateMedicalRecordPage(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MedicalRecordCard extends StatefulWidget {
//   final QueryDocumentSnapshot issue;

//   const MedicalRecordCard({super.key, required this.issue});

//   @override
//   _MedicalRecordCardState createState() => _MedicalRecordCardState();
// }

// class _MedicalRecordCardState extends State<MedicalRecordCard> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "teri mummy ka title ${widget.issue['issueTitle']}",
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       //color: _isOngoing ? Colors.green : Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     '${widget.record.date.day}/${widget.record.date.month}/${widget.record.date.year}',
//                     style: TextStyle(color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10.0),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Text('Ongoing: '),
//                     Checkbox(
//                       value: _isOngoing,
//                       onChanged: (value) {
//                         setState(() {
//                           _isOngoing = value!;
//                         });
//                         widget.record.ongoing = value!;
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Doctor Replied: '),
//                     Checkbox(
//                       value: _doctorReplied,
//                       onChanged: (value) {
//                         setState(() {
//                           _doctorReplied = value!;
//                         });
//                         widget.record.doctorReplied = value!;
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
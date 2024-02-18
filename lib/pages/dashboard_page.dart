import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<MedicalRecord> records = [
    // Replace with actual medical record data
    MedicalRecord(
      title: 'Headache',
      date: DateTime.now(),
      ongoing: true,
      doctorReplied: true,
    ),
    MedicalRecord(
      title: 'Stomach Ache',
      date: DateTime.now().subtract(const Duration(days: 5)),
      ongoing: false,
      doctorReplied: false,
    ),
    // Add more records here
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool ongoingValue = false;
  bool doctorRepliedValue = false;

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Medical Record',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  dateController.text = pickedDate.toString();
                }
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text('Ongoing: '),
                Checkbox(
                  value: ongoingValue,
                  onChanged: (value) {
                    setState(() {
                      ongoingValue = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Doctor Replied: '),
                Checkbox(
                  value: doctorRepliedValue,
                  onChanged: (value) {
                    setState(() {
                      doctorRepliedValue = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Create new medical record with entered data
                MedicalRecord newRecord = MedicalRecord(
                  title: titleController.text,
                  date: DateTime.parse(dateController.text),
                  ongoing: ongoingValue,
                  doctorReplied: doctorRepliedValue,
                );
                setState(() {
                  records.add(newRecord);
                });
                // Clear text fields after adding record
                titleController.clear();
                dateController.clear();
                ongoingValue = false;
                doctorRepliedValue = false;
              },
              child: const Text('Add Medical Record'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Medical Records:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: records.length,
              itemBuilder: (context, index) {
                return MedicalRecordCard(record: records[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalRecord {
  final String title;
  final DateTime date;
  final bool ongoing;
  final bool doctorReplied;

  MedicalRecord({
    required this.title,
    required this.date,
    this.ongoing = false,
    this.doctorReplied = false,
  });
}

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordCard({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${record.title}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Date: ${record.date.day}/${record.date.month}/${record.date.year}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Ongoing: ${record.ongoing ? 'Yes' : 'No'}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Doctor Replied: ${record.doctorReplied ? 'Yes' : 'No'}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: DashboardPage(),
  ));
}

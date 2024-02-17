import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
      ),
      body: Stack(
        children: [
          // Scrollable list of medical records
          ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: records.length,
            itemBuilder: (context, index) =>
                MedicalRecordCard(record: records[index]),
          ),
          // Fixed-position "Add" button
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                // Handle "Add" button press (e.g., navigate to create new record page)
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
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

  const MedicalRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                    record.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: record.ongoing ? Colors.green : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  //   Text(
                  //     DateFormat('MMM dd, yyyy').format(record.date),
                  //     style: TextStyle(color: Colors.grey[600]),
                  //   ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: record.doctorReplied ? Colors.blue : Colors.grey[200],
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

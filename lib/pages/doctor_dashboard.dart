import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
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
        title: const Text('Doctor Dashboard'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: records.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // Navigate to medical record details page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MedicalRecordDetails(record: records[index]),
              ),
            );
          },
          child: MedicalRecordCard(record: records[index]),
        ),
      ),
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
}

class MedicalRecord {
  final String title;
  final DateTime date;
  bool ongoing;
  bool doctorReplied;

  MedicalRecord({
    required this.title,
    required this.date,
    this.ongoing = false,
    this.doctorReplied = false,
  });
}

class MedicalRecordCard extends StatefulWidget {
  final MedicalRecord record;

  const MedicalRecordCard({Key? key, required this.record}) : super(key: key);

  @override
  _MedicalRecordCardState createState() => _MedicalRecordCardState();
}

class _MedicalRecordCardState extends State<MedicalRecordCard> {
  bool _isOngoing = false;
  bool _doctorReplied = false;

  @override
  void initState() {
    super.initState();
    _isOngoing = widget.record.ongoing;
    _doctorReplied = widget.record.doctorReplied;
  }

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
                    widget.record.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: _isOngoing ? Colors.green : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${widget.record.date.day}/${widget.record.date.month}/${widget.record.date.year}',
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
                      value: _isOngoing,
                      onChanged: (value) {
                        setState(() {
                          _isOngoing = value!;
                        });
                        widget.record.ongoing = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Doctor Replied: '),
                    Checkbox(
                      value: _doctorReplied,
                      onChanged: (value) {
                        setState(() {
                          _doctorReplied = value!;
                        });
                        widget.record.doctorReplied = value!;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalRecordDetails extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordDetails({Key? key, required this.record})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Date: ${record.date.day}/${record.date.month}/${record.date.year}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Ongoing: ${record.ongoing ? 'Yes' : 'No'}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Doctor Replied: ${record.doctorReplied ? 'Yes' : 'No'}',
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
                MedicalRecord newRecord = MedicalRecord(
                  title: _titleController.text,
                  date: DateTime.parse(_dateController.text),
                  ongoing: _ongoingValue,
                  doctorReplied: _doctorRepliedValue,
                );

                // Add the new record to the list of records
                setState(() {
                  records.add(newRecord);
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

void main() {
  runApp(const MaterialApp(
    home: DoctorDashboard(),
  ));
}

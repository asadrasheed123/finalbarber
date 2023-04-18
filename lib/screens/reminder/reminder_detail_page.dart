import 'package:flutter/material.dart';

class ReminderDetailPage extends StatelessWidget {
  final String appointmentType;
  final String appointmentDate;
  final String appointmentTime;

  ReminderDetailPage(
      {required this.appointmentTime,
      required this.appointmentType,
      required this.appointmentDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Appointment Type:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              appointmentType,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Appointment Date and Time:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              appointmentDate.toString(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              appointmentTime.toString(),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

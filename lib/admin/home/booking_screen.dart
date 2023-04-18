import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowAppointment extends StatefulWidget {
  const ShowAppointment({Key? key}) : super(key: key);

  @override
  _ShowAppointmentState createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('appointments').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No appointments found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var appointment = snapshot.data!.docs[index];
              var price = appointment['price'];
              var service = appointment['service'];
              var dateTime = appointment['dateTime'].toDate();


              return ListTile(
                title: Text('$price - $service'),
                subtitle: Text('Date: ${DateFormat.yMd().add_jm().format(dateTime)} - '),
              );
            },
          );
        },
      ),
    );
  }
}

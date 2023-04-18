import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>>? _stream;

  @override
  void initState() {
    super.initState();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _stream = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration Message')),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No message available'));
          }
          if (snapshot.data == null || !snapshot.data!.exists) {
            return Center(child: Text('No message available'));
          }
          String message = snapshot.data!.data()!['message'];
          if (message == null) {
            return Center(child: Text('No message available'));
          }
          return  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Icon(Icons.notification_important),
              SizedBox(width: 10),
              Text(
                message,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}

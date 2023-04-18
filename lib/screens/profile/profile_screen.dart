
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebarber/screens/profile/payment/payment_selection.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../admin/home/add_shope.dart';
import '../login_screen.dart';
import '../supportpage.dart';
final User? user = FirebaseAuth.instance.currentUser;
class ProfileScreen extends StatelessWidget {
  String _password = '';
  String? username = user?.displayName;
  String? email = user?.email;
  Future<void> _deleteUser(BuildContext context) async {
    try {
      // Show a confirmation dialog to the user
      bool confirmDelete = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Account?'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        ),
      );

      // If the user confirms the deletion, delete the account and navigate to the home screen
      if (confirmDelete == true) {
        // Delete user document from Firestore
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).delete();

        // Delete user account from Firebase Auth
        await FirebaseAuth.instance.currentUser!.delete();

        // Navigate to the HomeScreen after successful deletion
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      // Handle errors here
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account. Please try again.')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );

                    },
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
               Text(
               username?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                email ??'',
                style: GoogleFonts.roboto(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('My Payment Info'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PaymentMethodSelectionScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('My Profile'),
                onTap: () {
                  // Navigate to My Profile screen
                },
              ),

        
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {
                  // Navigate to Help screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
              ElevatedButton(
                onPressed: () => _deleteUser(context),
                child: Text(
                  'Delete Account',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactSupportPage()),
                  );

                },
                child: Text(
                  'Contact Support',
                  style: TextStyle(fontSize: 20),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfileScreen extends StatefulWidget {
  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  String _name = 'John Doe';
  String _email = 'johndoe@gmail.com';
  String _phone = '+1 234-567-8901';
  String _address = '123 Main St, Anytown USA';
  String _profileImageUrl = 'https://via.placeholder.com/150';
  final ImagePicker _picker = ImagePicker();
  final _auth = FirebaseAuth.instance;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _profileImageUrl = pickedFile as String;
    });
  }
  @override
  void initState() {
    super.initState();
    // Get the current user's information from Firebase authentication
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _name = currentUser.displayName ?? '';
      _email = currentUser.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Admin Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(_profileImageUrl),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _email,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(height: 1.0),
            ListTile(
              title: Text('Phone'),
              trailing: Text(_phone),
            ),
            Divider(height: 1.0),
            ListTile(
              title: Text('Address'),
              trailing: Text(_address),
            ),
            Divider(height: 1.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text('Edit Profile'),
                  onPressed: () {
                    // TODO: Navigate to edit profile screen
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

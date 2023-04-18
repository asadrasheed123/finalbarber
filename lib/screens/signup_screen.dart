
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_textFormfield.dart';
import '../custom_widgets/our_button.dart';
import 'home/home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isShopOwner = false;

  Future<void> _register() async {
    try {
      // Validate the form fields
      if (_formKey.currentState!.validate()) {
        String userType = _isShopOwner ? 'shop owner' : 'customer';

        // Call the Firebase Auth signup method
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // If the user creation is successful, update the user's display name
        await FirebaseAuth.instance.currentUser!.updateDisplayName(
          _usernameController.text.trim(),
        );

        // Store user registration data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'email': _emailController.text.trim(),
          'username': _usernameController.text.trim(),
          'userType': userType,
          'message': userType == 'shop owner' ? 'New shop registered' : 'New customer registered',
          // Add any other registration data you want to store
        });

        // Navigate to the LoginScreen after successful registration
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      // Handle errors here
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account. Please try again.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Image.asset(
        "assets/images/icon.png",
        width: 150,
        height: 150,
      ),

      Align(
        alignment: Alignment.center,
        child: Text(
          "Register On BARB",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
              fontSize: 25,
            ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text(
        'Register on on BARB?',

      ),

      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.0),
      //   child: Text('Customer'),
      // ),
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.0),
      //   child: Text(
      //     'Admin',
      //     style: TextStyle(fontFamily: 'Raleway'),
      //   ),
      // ),
      const SizedBox(height: 20.0),
    // Custom text field for username
    customTextField(
    controller: _usernameController,
    title: "Username",
    isPass: false,
    icon: Icon(
    Icons.email,
    size: 25,
    color: Theme.of(context).primaryColor,
    ),
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter a username';
    }
    return null;
    },
    ),

    // Custom text field for email
    customTextField(
    controller: _emailController,
    title: "Email",
    isPass: false,
    icon: Icon(
    Icons.email,
    size: 25,
    color: Theme.of(context).primaryColor,
    ),
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
    }
    return null;
    },
    ),

    // Custom text field for password
    customTextField(
    controller: _passwordController,
    title: "Password",
    isPass: true,
    icon: Icon(
    Icons.lock,
    size: 25,
    color: Theme.of(context).primaryColor,
    ),
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter a password';
    }
    if (value.length < 6) {
    return 'Password must be at least 6 characters long';
    }
    return null;
    },
    ),
      SizedBox(height: 10,),
      Text("Register As Shop"),
      DropdownButton(
        value: _isShopOwner,
        onChanged: (value) {
          setState(() {
            _isShopOwner = value as bool;
          });
        },
        items: [
          DropdownMenuItem(
            value: false,
            child: Text('No'),
          ),
          DropdownMenuItem(
            value: true,
            child: Text('Yes'),
          ),

    ],
    ),

      const SizedBox(height: 20.0),
    // Custom button for signup
      ourButton(
          onpress: _register,
          title: "Sign Up",
          Color: Colors.red.shade900),
      const SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Do have an account? ",
            style: TextStyle(fontFamily: 'Raleway'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
            child: const Text(
              "Login",
              style: TextStyle(fontFamily: 'Raleway'),
            ),
          )
        ],
      )
    ],
    ),
    ),
    ),
    ),

    );
  }
}

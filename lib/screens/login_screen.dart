
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebarber/screens/signup_screen.dart';

import '../admin/home/add_shope.dart';
import '../admin/home/admin_home_screen.dart';
import '../custom_widgets/custom_textFormfield.dart';
import '../custom_widgets/our_button.dart';
import 'home/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email1 = "barb@gmail.com";
  String password1 = "admin";
  String password2 = "";

  void emailValidate() async {
    try {

      // Call the Firebase Auth signin method
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Retrieve the user's data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      String userType = userDoc.get('userType');

      // Navigate to the appropriate screen based on user type
      if (userType == 'shop owner') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AddShopScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      // Handle errors here
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('')),
      );
      if (email1 == "barb@gmail.com" && password1 == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarberAdminHomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect email or password"),
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Barber App'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Welcome to BARB",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                          fontSize: 25,
                        )
                    )

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Text(
                  //   'Login  to your account',
                  //   style: TextStyle(fontSize: 15.0),
                  // ),

                  const SizedBox(height: 30.0),
                  //  This is our cutomize text field of email and its in cutome widget folder
                  customTextField(
                      controller: _emailController,
                      title: "Email",
                      isPass: false,
                      icon: Icon(
                        Icons.email,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      )),
                  const SizedBox(height: 20.0),
                  customTextField(
                      controller: _passwordController,
                      title: "Password",
                      isPass: true,
                      icon: Icon(
                        Icons.lock,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      )),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Raleway'),
                          ))
                    ],
                  ),
                  const SizedBox(height: 5.0),

                  ourButton(
                    onpress: () {



                      if (_formKey.currentState?.validate() == true) {
                        emailValidate();

                      }

                    },
                    title: "Log In",
                    Color: Colors.red.shade900,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignupScreen();
                          }));
                        },
                        child: const Text(
                          "Don't have an account? Register",
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
      ),
    );
  }
}

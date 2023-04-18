
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:flutter/material.dart';
import 'package:thebarber/screens/login_screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(logoWidth: 100,
      logo: Image.asset(
        "assets/images/icon.png",

      ),
      title: Text(
        "Welcome to The BARB",
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
            fontSize: 25,
           ),
      ),

      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.red,
      navigator: LoginScreen(),
      durationInSeconds: 5,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ourButton({
  onpress,
  Color,
  textColor,
  String? title,
}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color,
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onpress,
      child: Text(
        title.toString(),
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            ),
      ));
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField({
  String? title,
  String? hint,
  Icon? icon,
  controller,
  isPass,
  validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toString(),
        style: GoogleFonts.roboto(
            color: Colors.red.shade900,
            fontWeight: FontWeight.normal,
            fontSize: 16),
      ),
      // title!.text.color().fontFamily(semibold).size(16).mak,
      const SizedBox(
        height: 4,
      ),
      TextFormField(
          validator: validator,
          obscureText: isPass,
          cursorColor: Colors.red,
          controller: controller,
          decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.red),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 1, color: Colors.red.shade900)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 1, color: Colors.red.shade900)),
              hintText: hint,
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              prefixIcon: icon

              // border: InputBorder.none,
              )),
    ],
  );
}

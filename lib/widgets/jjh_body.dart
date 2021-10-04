import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget jjhBody(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 200),
      Center(
        child: Text(
          'xxxxxxxx',
          style: GoogleFonts.montserrat(
            fontSize: MediaQuery.of(context).size.width * 0.1,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(offset: Offset(1, 2), blurRadius: 3, color: Colors.black)
            ]
          ),
        ),
      ),
      SizedBox(height: 20),
      Center(
        child: Text(
          '출퇴근 버튼',
          style: GoogleFonts.montserrat(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(offset: Offset(1, 2), blurRadius: 3, color: Colors.black)
              ]
          ),
        ),
      ),
    ],
  );
}
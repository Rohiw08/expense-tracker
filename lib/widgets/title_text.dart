import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    required this.appbarTitleText,
    super.key,
  });

  // ignore: prefer_typing_uninitialized_variables
  final appbarTitleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      appbarTitleText,
      style: GoogleFonts.lato(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    );
  }
}

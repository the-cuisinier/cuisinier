import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatelessWidget {
  final String item;
  Tag({
    @required this.item
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 5
          ),
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent[100]
          ),
          child: Text(
            this.item,
            style: GoogleFonts.montserrat(),
          ),
        ),
      ),
    );
  }
}
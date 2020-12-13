import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class ProcessingDish extends StatelessWidget {

  final File image;
  ProcessingDish({
    @required this.image
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            width: size.width / 1.15,
            child: Image.file(image)
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: SizedBox(
              width: 42,
              child: LinearProgressIndicator(),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: Text(
                "Processing dish image, fetching results",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w300
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
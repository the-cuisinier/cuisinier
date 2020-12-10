import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Image.asset(
                  "assets/images/cat.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Center(
              child: Text(
                "Uh oh. We'll figure this out, sorry for the inconvenience!",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w300
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )
    );
  }
}
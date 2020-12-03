import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: LinearProgressIndicator(),
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  "The Cuisinier",
                  style: GoogleFonts.montserrat(
                      fontSize: 24, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

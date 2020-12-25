import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoFavoriteDishes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/emptySpace.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 24,
            ),
            Text("You haven't marked any dish as favorite. Just click the heart icon on a dish to mark it as favorite, and see them over here.",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DelicioraScreen extends StatefulWidget {
  @override
  _DelicioraScreenState createState() => _DelicioraScreenState();
}

class _DelicioraScreenState extends State<DelicioraScreen> {

  bool hasMadeRequest = false;

  @override
  Widget build(BuildContext context) {
    return hasMadeRequest ? SingleChildScrollView() : DelicioraInformationScreen();
  }
}

class DelicioraInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 54,
            ),
            Text(
              "What is Deliciora?",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 24
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Image.asset(
                "assets/images/ai-vector.jpg"
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32
              ),
              child: Text(
                "Deliciora is a smart system which recognises the image of a dish, and tells the recipe of the dish.\n\nJust click the image of a dish, and we'll tell you how you can make that dish. Feel free to try it out.",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.5
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ),
    );
  }
}
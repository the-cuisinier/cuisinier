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
            )
          ],
        )
      ),
    );
  }
}
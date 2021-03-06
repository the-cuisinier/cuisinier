import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cuisinier/utils/utilities.dart';

class DelicioraDishScreen extends StatelessWidget {
  final String title;
  final List<dynamic> ingredients, steps;
  final File image;

  DelicioraDishScreen({
    @required this.title,
    @required this.ingredients,
    @required this.steps,
    @required this.image
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    List<Widget> listOfIngredients = List();
    List<Widget> stepsToMakeDish = List();
    for (var item in this.ingredients){
      var newIngredient = Padding(
        padding: EdgeInsets.only(
          right: 8,
          bottom: 6
        ),
        child: Text(
          item,
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w300
          )
        ),
      );
      listOfIngredients.add(newIngredient);
    }
    for (var step in this.steps){
      var newStep = Padding(
        padding: EdgeInsets.only(
          right: 8,
          bottom: 6
        ),
        child: Text(
          step,
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w300
          )
        ),
      );
      stepsToMakeDish.add(newStep);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Icon(
              Icons.chevron_left
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25
              ),
              child: Text(
                this.title,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                )
              ),
            ),
            SizedBox(
              height: 32
            ),
            Center(
              child: Container(
                width: width / 1.35,
                child: Image.file(
                  this.image
                ),
              ),
            ),
            SizedBox(
              height: 32
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25
              ),
              child: Text(
                "Ingredients",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 8
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listOfIngredients
              ),
            ),
            SizedBox(
              height: 32
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25
              ),
              child: Text(
                "Instructions",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 8
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: stepsToMakeDish
              ),
            ),
            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.spotify),
        onPressed: () async {
          Random newRandomiserObject = Random();
          String playlistUrl = spotifyPlaylists[newRandomiserObject.nextInt(spotifyPlaylists.length)];
          if(await canLaunch(playlistUrl)){
            await launch(playlistUrl);
          }
        },
      ),
    );
  }
}
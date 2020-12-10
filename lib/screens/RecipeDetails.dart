import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsScreen extends StatefulWidget {
  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white30,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
              size: 45.0,
            ),
          ),
          elevation: 2.0,
          actions: [
            Icon(
              Icons.favorite_outline_outlined,
              color: Colors.black,
              size: 40.0,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/burger.jpg"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 10.0, left: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Aged Vegnog",
                            style: GoogleFonts.raleway(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 40.0,
                            )),
                        SizedBox(
                          width: 100.0,
                        ),
                        Icon(
                          Icons.share,
                          size: 30.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Ingredients",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25.0),
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "3 Tbs of Ghee",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "1 Pound Sugar",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "1 pint half-n-half",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "1 pint whole milk",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "1 pint heavy cream",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5.0),
                        Text(
                          "1 cup Jamaican rum (optional)",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Instructions",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                    Text(
                      "1.  Separate the eggs and store the whites for another purpose.",
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "2.  Beat the yolks with the sugar and nutmeg in a large mixing bowl until the mixture lightens in color and falls off the whisk in a solid",
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "3.  Combine dairy, booze and salt in a second bowl or pitcher and then slowly beat into the egg mixture.",
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "4.  Move to a large glass jar (or a couple of smaller ones) and store in the fridge for a minimum of 2 weeks. A month would be better, and two better still. In fact, there's nothing that says you couldn't age it a year, but I've just never been able to wait that long. (And yes, you can also drink it right away.)",
                      maxLines: 7,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.montserrat(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
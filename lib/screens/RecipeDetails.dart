import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';

class RecipeDetailsScreen extends StatefulWidget {
  
  final String recipeId;
  RecipeDetailsScreen({
    @required this.recipeId
  });

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {

  Map<String, dynamic> recipeDetails;
  List<Widget> listOfIngredients = List();
  List<Widget> listOfSteps = List();

  fetchRecipeDetails() async {
    var recipeDocRef = await FirebaseFirestore.instance.collection("recipes").doc(widget.recipeId).get();
    var recipeTutorial = recipeDocRef.data();
    for (var item in recipeTutorial["ingredients"]) {
      var newTempItem = Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5
        ),
        child: Row(
          children: [
            Icon(Icons.book),
            SizedBox(width: 5.0),
            Flexible(
              child: Text(
                item,
                style: GoogleFonts.montserrat(
                    fontSize: 15.0, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      );
      listOfIngredients.add(newTempItem);
    }
    if(recipeTutorial["instructions"].runtimeType == String){
      var nextStep = Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3
          ),
          child: Text(
            recipeTutorial["instructions"],
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: GoogleFonts.montserrat(
                fontSize: 15.0, fontWeight: FontWeight.w300),
          )
        );
        listOfSteps.add(nextStep);
    }
    else{
      for (var step in recipeTutorial["instructions"]) {
        var nextStep = Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3
          ),
          child: Text(
            step,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: GoogleFonts.montserrat(
                fontSize: 15.0, fontWeight: FontWeight.w300),
          )
        );
        listOfSteps.add(nextStep);
      }
    }
    setState(() {
      recipeDetails = recipeTutorial;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return recipeDetails != null ? Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white38,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left_outlined,
                color: Colors.black,
                size: 32.0,
              ),
            ),
          ),
          elevation: 0
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      recipeDetails["imageUrl"]
                    ),
                    fit: BoxFit.cover
                  )
                ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Aged Vegnog",
                          style: GoogleFonts.montserrat(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 28
                          )
                        ),
                        Icon(
                          Icons.share,
                          size: 30.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Ingredients",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 25.0),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: listOfIngredients
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Instructions",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                    Column(
                      children: listOfSteps,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ) : Scaffold(
        body: WaitingWidget(),
      );
  }
}
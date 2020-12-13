import 'package:cuisinier/utils/EmptyWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/screens/addIngredient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cuisinier/screens/editIngredientQuantity.dart';

class InventoryScreen extends StatefulWidget {

  final FirebaseAuth auth;
  final AuthHandlerState authHandler;

  InventoryScreen({
    @required this.auth,
    @required this.authHandler
  });

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Inventory",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12
            ),
            child: Icon(
              Icons.chevron_left,
              color: Colors.black
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("inventory").doc(widget.authHandler.user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return WaitingWidget();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
                DocumentSnapshot temp = snapshot.data;
              Map<String, dynamic> ingredients = temp.data();
            if (ingredients == null) {
              return EmptyWidget();
            } else {
              List<Widget> listOfIngredients = List();
              for (var key in ingredients.keys) {
                Widget newIngredient = ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => EditUpdateIngredientScreen(
                          user: widget.authHandler.user,
                          unit: ingredients[key]["unit"].toString(),
                          ingredientName: key,
                          quantity: ingredients[key]["quantity"]
                        )
                      )
                    ).then((value) => setState((){}));
                  },
                  title: Text(
                    key,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                    )
                  ),
                  subtitle: Text(
                    ingredients[key]["quantity"].toString() + " " + ingredients[key]["unit"].toString(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                  ),
                );
                listOfIngredients.add(newIngredient);
              }
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20
                        ),
                        child: Text(
                          "Add a new ingredient or update your inventory list by tapping on the ingredient!",
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: listOfIngredients,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return ErrorScreenWidget();
          }
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddIngredientScreen(
                user: widget.authHandler.user
              )
            )
          ).then((value){
            setState(() {});
          });
        },
        icon: Icon(
          FontAwesomeIcons.pencilAlt,
          size: 18,
        ),
        label: Text(
          "Add Ingredients"
        )
      ),
    );
  }
}
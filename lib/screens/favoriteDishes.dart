import 'package:cuisinier/screens/RecipeCard.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/utils/NoFavorites.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteDishes extends StatefulWidget {

  final FirebaseAuth auth;
  final AuthHandlerState authHandler;
  
  FavoriteDishes({
    @required this.authHandler,
    @required this.auth
  });

  @override
  _FavoriteDishesState createState() => _FavoriteDishesState();
}

class _FavoriteDishesState extends State<FavoriteDishes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.chevron_left,
            color: Colors.black
          ),
        ),
        title: Text(
          "Favorite Dishes",
          style: GoogleFonts.montserrat(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(widget.authHandler.user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return WaitingWidget();
            }
            else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
                DocumentSnapshot temp = snapshot.data;
                Map<String, dynamic> ingredients = temp.data();
                if(ingredients == null){
                  return NoFavoriteDishes();
                }
                else{
                  List listOfFavoriteDishes = ingredients["favorites"];
                  return FavoriteDishesListBuilder(
                    favDishesId: listOfFavoriteDishes,
                    authHandler: widget.authHandler,
                  );
                }
            }
            else{
              return ErrorScreenWidget();
            }
          },
        ),
      ),
    );
  }
}

class FavoriteDishesListBuilder extends StatefulWidget {

  final List favDishesId;
  final AuthHandlerState authHandler;

  FavoriteDishesListBuilder({
    @required this.favDishesId,
    @required this.authHandler
  });
  
  @override
  _FavoriteDishesListBuilderState createState() => _FavoriteDishesListBuilderState();
}

class _FavoriteDishesListBuilderState extends State<FavoriteDishesListBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("dish-index").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data != null){
          List<Map<String, dynamic>> favDishesList = [];
          for (var item in snapshot.data.documents){
            if(widget.favDishesId.contains(item.documentID)){
              favDishesList.add(item.data());
            }
          }
          print(favDishesList.length);
          return RecipeCard(docs: favDishesList, authHandler: widget.authHandler);
        }
        else{
          return SizedBox();
        }
      }
    );
  }
}
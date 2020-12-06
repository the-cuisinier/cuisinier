import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/utils/EmptyWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import '../utils/tempRecipeCard.dart';
import 'package:cuisinier/screens/profile.dart';
import 'package:cuisinier/screens/addIngredient.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final AuthHandlerState authHandler;
  HomeScreen({@required this.auth, @required this.authHandler});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  formatText(String data) {
    if (data.length <= 180) {
      return data;
    }
    return data.substring(0, 180) + "...";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "The Cuisiner",
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfileScreen(
                          auth: widget.auth,
                          authHandler: widget.authHandler,
                        ))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Share.share(
                  "Hey\nJoin me in using the cuisinier to to recommend you dishes you can cook in the most optimal way. Check out https://the-cuisinier.web.app/ right now!");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Icons.share,
                color: Colors.black,
                size: 28,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("recipes").limit(18).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return WaitingWidget();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.documents.length == 0) {
              return EmptyWidget();
            } else {
              return RecipeCard(docs: snapshot.data.documents);
            }
          } else {
            return ErrorScreenWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddIngredientScreen(
                user: widget.authHandler.user
              )
            )
          );
        },
        icon: Icon(Icons.edit),
        label: Text("Add ingredients"),
      ),
    );
  }
}

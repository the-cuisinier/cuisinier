import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/utils/EmptyWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import 'package:cuisinier/screens/RecipeCard.dart';

class CookBookScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final AuthHandlerState authHandler;
  CookBookScreen({@required this.auth, @required this.authHandler});

  @override
  _CookBookScreenState createState() => _CookBookScreenState();
}

class _CookBookScreenState extends State<CookBookScreen> {

  formatText(String data) {
    if (data.length <= 180) {
      return data;
    }
    return data.substring(0, 180) + "...";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "CookBook",
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w500),
        )
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("dish-index").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return WaitingWidget();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.documents.length == 0) {
              return EmptyWidget();
            } else {
              return RecipeCard(
                docs: snapshot.data.documents,
                authHandler: widget.authHandler
              );
            }
          } else {
            return ErrorScreenWidget();
          }
        },
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/utils/EmptyWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import '../utils/tempRecipeCard.dart';
import 'package:cuisinier/screens/addIngredient.dart';
import 'package:cuisinier/screens/splash.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final AuthHandlerState authHandler;
  HomeScreen({@required this.auth, @required this.authHandler});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isAccountLoaded = false;
  Map<String, dynamic> inventory;

  formatText(String data) {
    if (data.length <= 180) {
      return data;
    }
    return data.substring(0, 180) + "...";
  }

  fetchInventory() async {
    var tempInventory = await FirebaseFirestore.instance.collection("inventory").doc(widget.authHandler.user.uid).get();
    inventory = tempInventory.data();
    // for (var key in inventory.keys) {
    //   print(key);
    // }
    setState(() {
      isAccountLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchInventory();
  }

  @override
  Widget build(BuildContext context) {
    return isAccountLoaded ? Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("dish-index").limit(12).snapshots(),
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
          ).then((data){
            setState(() {
              isAccountLoaded = false;
            });
            inventory.clear();
            fetchInventory();
          });
        },
        icon: Icon(Icons.edit),
        label: Text("Add ingredients"),
      )
    ) : SplashScreen();
  }
}

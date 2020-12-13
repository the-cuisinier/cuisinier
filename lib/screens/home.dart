import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/utils/EmptyWidget.dart';
import 'package:cuisinier/utils/ErrorScreen.dart';
import 'package:cuisinier/screens/RecipeCard.dart';
import 'package:cuisinier/screens/inventory.dart';
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


  getDishes() async {
    Map<String, dynamic> dishesThatCanBeCooked = {};
    var collectionRef = FirebaseFirestore.instance.collection("index");
    for (var ingredient in inventory.keys) {
      try {
        var fetchingDishes = await collectionRef.doc(ingredient).get();
        var ingredientSpecificDishMap = fetchingDishes.data();
        if(ingredientSpecificDishMap != null){
          for (var dishes in ingredientSpecificDishMap["recipes"]) {
            try {
              dishesThatCanBeCooked[dishes] = dishesThatCanBeCooked[dishes] + 1;
            } catch (e) {
              dishesThatCanBeCooked[dishes] = 1;
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }
    List resultsId = List();
    Map<String, dynamic> sortedOrderMap = {};
    for (var key in dishesThatCanBeCooked.keys) {
      var newKey = dishesThatCanBeCooked[key].toString();
      if(sortedOrderMap.containsKey(newKey)){
        List newList = sortedOrderMap[newKey];
        newList.add(key);
        sortedOrderMap["$newKey"] = newList;
      }
      else {
        List tempNewList = List();
        tempNewList.add(key);
        sortedOrderMap["$newKey"] = tempNewList;
      }
    }
    for (var key in sortedOrderMap.keys.toList().reversed) {
      for (var item in sortedOrderMap[key]) {
        resultsId.add(item);
      }
    }
    List results = List();
    CollectionReference dishIndexRef = FirebaseFirestore.instance.collection("dish-index");
    for (var id in resultsId) {
      var details = await dishIndexRef.doc(id).get();
      var data = details.data();
      results.add(data);
    }
    return results;
  }


  fetchInventory() async {
    var tempInventory = await FirebaseFirestore.instance.collection("inventory").doc(widget.authHandler.user.uid).get();
    inventory = tempInventory.data();
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
        stream: Stream.fromFuture(getDishes()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return WaitingWidget();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return EmptyWidget();
            } else {
              return RecipeCard(
                docs: snapshot.data,
                authHandler: widget.authHandler
              );
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
              builder: (BuildContext context) => InventoryScreen(
                auth: widget.auth,
                authHandler: widget.authHandler
              )
            )
          ).then((data) async {
            if(inventory != null){
              inventory.clear();
            }
            fetchInventory();
            setState(() {
              isAccountLoaded = false;
            });
          });
        },
        icon: Icon(
          FontAwesomeIcons.stickyNote
        ),
        label: Text("Inventory"),
      )
    ) : SplashScreen();
  }
}

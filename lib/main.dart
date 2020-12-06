import 'package:cuisinier/recipeDetails.dart';
import 'package:flutter/material.dart';
import 'package:cuisinier/recipeDetails.dart';
//import 'package:cuisinier/utils/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Thoughts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: recipeDetails()
        //AuthHandler()
        );
  }
}

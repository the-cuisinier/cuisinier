import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cuisinier/utils/utilities.dart';

class AddIngredientScreen extends StatefulWidget {
  final User user;
  AddIngredientScreen({
    @required this.user
  });
  @override
  _AddIngredientScreenState createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  bool isSubmittingForm = false;
  String dropdownValue = 'Grams';

  TextEditingController ingredientNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  FocusNode ingredientNameFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return isSubmittingForm ? Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: MediaQuery.of(context).size.height / 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Ingredients",
                style: GoogleFonts.montserrat(
                  fontSize: 24
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Add the ingredient purchased. Please make sure the quantity is specified in gm and ml.",
                style: GoogleFonts.montserrat(
                  fontSize: 16
                )
              ),
              SizedBox(
                height: 42,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: true,
                controller: ingredientNameController,
                focusNode: ingredientNameFocusNode,
                style: GoogleFonts.montserrat(),
                autofocus: true,
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  ingredientNameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(quantityFocusNode);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: GoogleFonts.montserrat(),
                  hintText: 'For example, onions, tomatoes',
                  labelText: "Ingredient Name"
                ),
              ),
              SizedBox(
                height: 36,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autocorrect: true,
                controller: quantityController,
                focusNode: quantityFocusNode,
                style: GoogleFonts.montserrat(),
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  quantityFocusNode.unfocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: GoogleFonts.montserrat(),
                  hintText: 'For example, 100g, 30ml',
                  labelText: "Ingredient Quantity"
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Unit",
                style: GoogleFonts.montserrat(
                  fontSize: 18
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                items: <String>['Grams', 'ml', 'number', 'cups', 'tsp', 'tbsp', 'leaves']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12
                      ),
                      child: Text(
                        value,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w300
                        )
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue){
                  setState(() {
                    dropdownValue = newValue;
                  });
                }
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isSubmittingForm = true;
          });
          Map<String, dynamic> ingredientDetails = {
            "unit": dropdownValue,
            "quantity": int.parse(quantityController.text.toString())
          };
          var dataRef = FirebaseFirestore.instance.collection("inventory").doc(widget.user.uid);
          var data = await dataRef.get();
          Map<String, dynamic> inventory = data.data();
          bool haveUpdatedMap = false;
          for (var key in inventory.keys) {
            if(hamingDistanceErrorPercentage(key, ingredientNameController.text) <= 0.12){
              inventory[key]["quantity"] = inventory[key]["quantity"] + ingredientDetails["quantity"];
              haveUpdatedMap = true;
              break;
            }
          }
          if(haveUpdatedMap == false){
            inventory[ingredientNameController.text] = ingredientDetails;
          }
          await dataRef.set(inventory);
          setState(() {
            isSubmittingForm = false;
          });
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_right_rounded
        ),
      ),
    );
  }
}
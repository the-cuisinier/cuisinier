import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUpdateIngredientScreen extends StatefulWidget {
  final User user;
  final String ingredientName;
  final String unit;
  final int quantity;

  EditUpdateIngredientScreen({
    @required this.user,
    @required this.unit,
    @required this.ingredientName,
    @required this.quantity
  });
  @override
  _EditUpdateIngredientScreenState createState() => _EditUpdateIngredientScreenState();
}

class _EditUpdateIngredientScreenState extends State<EditUpdateIngredientScreen> {
  bool isSubmittingForm = false;
  String dropdownValue = 'Grams';

  TextEditingController quantityController = TextEditingController();
  FocusNode quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.quantity.toString();
  }

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
                "Update Ingredient Quantity",
                style: GoogleFonts.montserrat(
                  fontSize: 24
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Update the ingredient's quantity in your inventory.",
                style: GoogleFonts.montserrat(
                  fontSize: 16
                )
              ),
              SizedBox(
                height: 42,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autocorrect: true,
                autofocus: true,
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
            "unit": widget.unit,
            "quantity": int.parse(quantityController.text.toString())
          };
          var dataRef = FirebaseFirestore.instance.collection("inventory").doc(widget.user.uid);
          var data = await dataRef.get();
          Map<String, dynamic> inventory = data.data();
          inventory[widget.ingredientName] = ingredientDetails;
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
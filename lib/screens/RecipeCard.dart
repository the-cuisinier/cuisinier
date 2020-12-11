import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cuisinier/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuisinier/utils/WaitingWidget.dart';
import 'package:cuisinier/screens/RecipeDetails.dart';

class RecipeCard extends StatefulWidget {

  final List docs;
  final AuthHandlerState authHandler;
  RecipeCard({
    @required this.docs,
    @required this.authHandler
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {

  List favoriteDishes;

  getDetails() async {
    String uid = widget.authHandler.user.uid;
    var details = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map<String, dynamic> userDetails = details.data();
    favoriteDishes = userDetails["favorites"];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1.2;
    var height = 0.64 * width;
    return Padding(
      padding: EdgeInsets.only(bottom: 64),
      child: favoriteDishes != null ? ListView.builder(
          itemCount: widget.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RecipeDetailsScreen(
                        recipeId: widget.docs[index]["id"],
                      )
                    )
                  ).then((value){
                    favoriteDishes.clear();
                    setState(() {
                      getDetails();
                    });
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.docs[index]["imageUrl"],
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          color: Colors.white60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.docs[index]["name"],
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              InkWell(
                                onTap: () async {
                                  var userRef = FirebaseFirestore.instance.collection("users").doc(widget.authHandler.user.uid);
                                  var details = await userRef.get();
                                  Map<String, dynamic> userDetails = details.data();
                                  String recipeId = widget.docs[index]["id"];
                                  if(favoriteDishes.contains(recipeId)){
                                    favoriteDishes.remove(recipeId);
                                  }
                                  else{
                                    favoriteDishes.add(recipeId);
                                  }
                                  userDetails["favorites"] = favoriteDishes;
                                  await userRef.set(userDetails);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: favoriteDishes.contains(widget.docs[index]["id"]) ? Icon(
                                    Icons.favorite,
                                    size: 32,
                                    color: Colors.redAccent,
                                  ) : Icon(
                                    Icons.favorite_border,
                                    size: 32
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ) : WaitingWidget()
    );
  }
}

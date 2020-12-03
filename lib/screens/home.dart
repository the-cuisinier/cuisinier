import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import 'package:cuisinier/utils/auth.dart';
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/fetchData.png"),
                  SizedBox(
                    height: 32,
                  ),
                  Text("Fetching your data")
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/emptySpace.png",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Please add some ingredients so that we can suggest some recipes!",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(bottom: 64),
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Widget> listOfTagElements = List();
                      for (var item in snapshot.data.documents[index]["tags"]) {
                        var newTag = Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5
                              ),
                              decoration: BoxDecoration(
                                color: Colors.lightGreenAccent[100]
                              ),
                              child: Text(
                                item,
                                style: GoogleFonts.montserrat(),
                              ),
                            ),
                          ),
                        );
                        listOfTagElements.add(newTag);
                      }
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data.documents[index]["name"],
                                    style: GoogleFonts.montserrat(
                                        color: Colors.green,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: listOfTagElements
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.article_outlined),
                                      label: Text(
                                        "Read more",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14
                                        ),
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          } else {
            return Center(
                child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Image.asset(
                        "assets/images/cat.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ));
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

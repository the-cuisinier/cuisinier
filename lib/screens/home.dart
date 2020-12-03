import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/screens/profile.dart';

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
          "Your thoughts",
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
        stream: FirebaseFirestore.instance
            .collection("posts")
            .where("uid", isEqualTo: widget.authHandler.user.uid)
            .snapshots(),
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
                      Text("Please add your thoughts!",
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w400))
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
                                    snapshot.data.documents[index]["title"],
                                    style: GoogleFonts.montserrat(
                                        color: Colors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data.documents[index]["date"]
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              snapshot
                                                  .data.documents[index]["time"]
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          formatText(snapshot.data
                                              .documents[index]["details"]),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () async {
                                          String docId =
                                              snapshot.data.documents[index].id;
                                          Alert(
                                            context: context,
                                            type: AlertType.warning,
                                            title: "Delete thought?",
                                            desc:
                                                "You are going to delete this post. Are you sure you want to delete this?",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Go Back",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                color: Colors.grey,
                                              ),
                                              DialogButton(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    Future.delayed(
                                                        Duration(seconds: 1));
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("posts")
                                                        .doc(docId)
                                                        .delete();
                                                  },
                                                  color: Colors.red)
                                            ],
                                          ).show();
                                        },
                                        icon:
                                            Icon(Icons.delete_forever_rounded),
                                        label: Text(
                                          "Delete post",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14),
                                        )),
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.article_outlined),
                                        label: Text(
                                          "Read more",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14),
                                        ))
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
        onPressed: () {},
        icon: Icon(Icons.edit),
        label: Text("Add ingredients"),
      ),
    );
  }
}

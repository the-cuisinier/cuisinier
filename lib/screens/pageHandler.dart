import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/screens/home.dart';
import 'package:cuisinier/screens/profile.dart';
import 'package:cuisinier/screens/deliciora.dart';
import 'package:cuisinier/screens/cookBook.dart';

class PageHandler extends StatefulWidget {
  final FirebaseAuth auth;
  final AuthHandlerState authHandler;

  PageHandler({
    @required this.authHandler,
    @required this.auth
  });

  @override
  _PageHandlerState createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler> {

  Widget currPage;

  @override
  void initState() {
    super.initState();
    currPage = HomeScreen(
      auth: widget.auth,
      authHandler: widget.authHandler
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          "The Cuisiner",
          style: GoogleFonts.montserrat(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
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
      body: currPage,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.authHandler.user.photoURL
                        ),
                        radius: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.authHandler.user.displayName,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 18
                              )
                            ),
                            SizedBox(),
                            Text(
                              widget.authHandler.user.email,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 15
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background-vector.jpg"),
                  fit: BoxFit.cover
                )
              )
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                setState(() {
                  currPage = HomeScreen(
                    auth: widget.auth,
                    authHandler: widget.authHandler
                  );
                });
              },
              title: Text(
                "MagicBook",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                setState(() {
                  currPage = ProfileScreen(
                    auth: widget.auth,
                    authHandler: widget.authHandler,
                  );
                });
              },
              title: Text(
                "My Profile",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                setState(() {
                  currPage = CookBookScreen(
                    auth: widget.auth,
                    authHandler: widget.authHandler,
                  );
                });
              },
              title: Text(
                "CookBook",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                setState(() {
                  currPage = DelicioraScreen();
                });
              },
              title: Text(
                "Deliciora",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
              ),
            ),
            ListTile(
              onTap: () async{
                Navigator.pop(context);
                String websiteUrl = 'https://the-cuisinier.web.app/';
                if(await canLaunch(websiteUrl)){
                  await launch(websiteUrl);
                }
                else{
                  Alert(
                      context: context,
                      title:
                          "An error occured.")
                  .show();
                }
              },
              title: Text(
                "About the Developers",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
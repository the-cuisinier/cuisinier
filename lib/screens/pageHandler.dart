import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/screens/home.dart';
import 'package:cuisinier/screens/profile.dart';
import 'package:cuisinier/screens/deliciora.dart';

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
              child: Text(
                "The Cuisiner",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24
                )
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent
              )
            ),
            ListTile(
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
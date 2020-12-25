import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cuisinier/utils/auth.dart';
import 'package:cuisinier/screens/favoriteDishes.dart';

class ProfileScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final AuthHandlerState authHandler;
  ProfileScreen({@required this.auth, @required this.authHandler});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  handleSignOut(FirebaseAuth auth) async {
    widget.authHandler.setState(() {
      widget.authHandler.isSignedIn = null;
      widget.authHandler.user = null;
    });
    await auth.signOut();
    await GoogleSignIn().signOut();
    widget.authHandler.setState(() {
      widget.authHandler.isSignedIn = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Text(
              "Profile",
              style: GoogleFonts.montserrat(
                  fontSize: 42, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 54,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.authHandler.user.photoURL),
              radius: 64,
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              widget.authHandler.user.displayName,
              style: GoogleFonts.montserrat(
                  fontSize: 32, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.authHandler.user.email,
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 72,
            ),
            FlatButton(
                color: Colors.white,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(64.0),
                    side: BorderSide(color: Colors.red, width: 2)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FavoriteDishes(authHandler: widget.authHandler, auth: widget.auth))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        child: Icon(Icons.favorite, color: Colors.red,)
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Favorite Dishes",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                )),
            SizedBox(
              height: 24,
            ),
            FlatButton(
                color: Colors.white,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(64.0),
                    side: BorderSide(color: Color(0xFF4285F4), width: 2)),
                onPressed: () => handleSignOut(widget.auth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        child: Image.asset(
                          "assets/images/google_logo.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Sign Out",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

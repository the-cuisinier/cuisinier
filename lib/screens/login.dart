import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:cuisinier/utils/auth.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  AuthHandlerState authHandler;
  FirebaseAuth auth;
  LoginScreen({@required this.auth, this.authHandler});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  handleSignIn(FirebaseAuth auth) async {
    GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    try {
      GoogleSignInAuthentication googleAuthCredential =
          await googleSignInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuthCredential.accessToken,
          idToken: googleAuthCredential.idToken);

      UserCredential userCredential =
          await widget.auth.signInWithCredential(authCredential);

      User tempUser = userCredential.user;
      bool userSignedIn = await GoogleSignIn().isSignedIn();
      widget.authHandler.setState(() {
        widget.authHandler.user = tempUser;
        widget.authHandler.isSignedIn = userSignedIn;
      });
    } catch (e) {
      print(e);
      Alert(
              context: context,
              title:
                  "Couldn't sign you in. Please check your internet connection and try again.")
          .show();
    }
    String name = widget.authHandler.user.displayName;
    String email = widget.authHandler.user.email;
    String photoUrl = widget.authHandler.user.photoURL;
    String uid = widget.authHandler.user.uid;

    Map<String, dynamic> userDetails = {
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "uid": uid
    };

    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    await usersRef.doc(uid).set(userDetails);
  }

  @override
  void initState() {
    super.initState();
    print(widget.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Text(
                "The Cuisiner",
                style: GoogleFonts.montserrat(
                    fontSize: MediaQuery.of(context).size.width < 380 ? 32 : 42,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 54,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 2,
                  child: FlareActor(
                    "assets/flares/Chef.flr",
                    animation: "active",
                    fit: BoxFit.cover,
                  )
              ),
              SizedBox(
                height: 52,
              ),
              FlatButton(
                  color: Colors.white,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64.0),
                      side: BorderSide(color: Color(0xFF4285F4), width: 2)),
                  onPressed: () => handleSignIn(widget.auth),
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
                        Text("Sign In",
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
      ),
    );
  }
}

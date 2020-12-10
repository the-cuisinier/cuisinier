import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cuisinier/screens/splash.dart';
import 'package:cuisinier/screens/login.dart';
import 'package:cuisinier/screens/home.dart';
import 'package:cuisinier/screens/pageHandler.dart';

class AuthHandler extends StatefulWidget {
  @override
  AuthHandlerState createState() => AuthHandlerState();
}

class AuthHandlerState extends State<AuthHandler> {
  bool isSignedIn;
  User user;
  FirebaseAuth auth;

  checkIfUserIsSignedIn(FirebaseAuth _auth) async {
    bool signInStatus = await GoogleSignIn().isSignedIn();
    if (signInStatus) {
      setState(() {
        isSignedIn = signInStatus;
        user = _auth.currentUser;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    FirebaseAuth tempAuth = FirebaseAuth.instanceFor(app: defaultApp);

    setState(() {
      auth = tempAuth;
    });
    checkIfUserIsSignedIn(auth);
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return isSignedIn == null
        ? SplashScreen()
        : isSignedIn == true
            ? PageHandler(
                auth: auth,
                authHandler: this,
              )
            : LoginScreen(
                auth: auth,
                authHandler: this,
              );
  }
}

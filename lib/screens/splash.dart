import 'package:flutter/material.dart';
import 'package:protrack/screens/home.dart';
import 'package:protrack/screens/welcome.dart';
import 'package:protrack/screens/loading.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;
import 'package:firebase_core/firebase_core.dart' as fCore;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fCore.Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return WelcomeScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return checkUserAlreadyLogin() ? HomeScreen() : WelcomeScreen();
        }

        return LoadingScreen();
      },
    );
  }
}

bool checkUserAlreadyLogin() {
  try {
    fAuth.FirebaseAuth _auth = fAuth.FirebaseAuth.instance;
    bool isLogin = _auth.currentUser != null && !_auth.currentUser.isAnonymous;
    return isLogin;
  } catch (e) {
    print('Check login status failed!');
    return false;
  }
}

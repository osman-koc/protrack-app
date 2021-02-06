import 'package:flutter/material.dart';
import 'package:protrack/screens/home.dart';
import 'package:protrack/screens/welcome.dart';
import 'package:protrack/screens/loading.dart';
import 'package:firebase_auth/firebase_auth.dart' as fA;
import 'package:firebase_core/firebase_core.dart' as fC;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fC.Firebase.initializeApp(),
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
    fA.FirebaseAuth _auth = fA.FirebaseAuth.instance;
    bool isLogin = _auth.currentUser != null && !_auth.currentUser.isAnonymous;
    return isLogin;
  } catch (e) {
    print('Check login status failed!');
    return false;
  }
}

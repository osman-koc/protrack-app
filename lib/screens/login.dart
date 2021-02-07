import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:protrack/components/already_have_an_account_acheck.dart';
import 'package:protrack/components/login/background.dart';
import 'package:protrack/components/rounded_button.dart';
import 'package:protrack/components/rounded_input_field.dart';
import 'package:protrack/components/rounded_password_field.dart';
import 'package:protrack/constants/assets/svg_constants.dart';
import 'package:protrack/extensions/toaster.dart';
import 'package:protrack/screens/home.dart';
import 'package:protrack/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart' as fA;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String _userMail;
  String _userPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "GİRİŞ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              SvgConst.login,
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Eposta",
              onChanged: (value) {
                _userMail = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _userPassword = value;
              },
            ),
            RoundedButton(
              text: "GİRİŞ YAP",
              press: () {
                if (_userMail == null || _userMail.length <= 5) {
                  ConstToast.error('Geçersiz bir e-posta adresi girdiniz.');
                } else if (_userPassword == null || _userPassword.length <= 6) {
                  ConstToast.error('Geçersiz bir parola girdiniz.');
                } else {
                  _loginUser(new LoginData(
                          name: _userMail, password: _userPassword))
                      .then((user) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).catchError((e) {
                    print(e);
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<fA.User> _loginUser(LoginData loginData) async =>
      _handleSignIn(loginData.name.trim(), loginData.password).catchError((e) {
        ConstToast.error('E-posta veya şifreyi yanlış girdiniz!');
      });

  Future<fA.User> _handleSignIn(String email, String password) async {
    final fA.FirebaseAuth _auth = fA.FirebaseAuth.instance;
    final fA.User _user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }
}

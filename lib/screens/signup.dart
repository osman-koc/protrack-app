import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:protrack/constants/assets/svg_constants.dart';
import 'package:protrack/util/toaster.dart';
import 'package:protrack/screens/home.dart';
import 'package:protrack/screens/login.dart';
import 'package:protrack/components/signup/background.dart';
import 'package:protrack/components/signup/or_divider.dart';
import 'package:protrack/components/signup/social_icon.dart';
import 'package:protrack/components/already_have_an_account_acheck.dart';
import 'package:protrack/components/rounded_button.dart';
import 'package:protrack/components/rounded_input_field.dart';
import 'package:protrack/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart' as fA;
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupBody(),
    );
  }
}

class SignupBody extends StatefulWidget {
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  String _userMail, _userPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "KAYIT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              SvgConst.signup,
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "E-posta",
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
              text: "KAYIT OL",
              press: () {
                if (_userMail == null || _userMail.length <= 5) {
                  ConstToast.error('Geçersiz bir e-posta adresi girdiniz.');
                } else if (_userPassword == null || _userPassword.length <= 6) {
                  ConstToast.error('Geçersiz bir parola girdiniz.');
                } else {
                  _signUpUser(new LoginData(
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
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: SvgConst.facebook,
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: SvgConst.twitter,
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: SvgConst.googlePlus,
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<fA.User> _signUpUser(LoginData loginData) async =>
      _handleSignUp(loginData.name.trim(), loginData.password).catchError((e) {
        ConstToast.error(
            'Kayıt yapılamadı. Bilgileri kontrol edip tekrar deneyin.');
      });

  Future<fA.User> _handleSignUp(String email, String password) async {
    final fA.FirebaseAuth _auth = fA.FirebaseAuth.instance;
    final fA.User _user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return _user;
  }
}

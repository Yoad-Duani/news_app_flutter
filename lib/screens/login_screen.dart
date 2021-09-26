import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/style/theme.dart' as myStyle;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myStyle.MyColors.mainColor.withOpacity(0.6),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 80.0, top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            FlutterLogo(
              size: 120.0,
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hey There,\nWelcome Back",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login to your account to continue",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50.0),
              ),
              onPressed: () {},
              icon: Icon(
                EvaIcons.google,
                color: Colors.red,
              ),
              label: Text("Sign Up with Google"),
            ),
            SizedBox(
              height: 40.0,
            ),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "Log in",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

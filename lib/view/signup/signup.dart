import 'package:eschool/view/signup/desktop_mode.dart';
import 'package:eschool/view/signup/mobile_mode.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 1024) {
            return MobileSignUpMode();
          } else {
            return DesktopSignUpMode();
          }
        },
      ),
    );
  }
}

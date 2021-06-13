import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'desktop_mode.dart';
import 'mobile_mode.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();

  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool("isLoggedIn")!;
      print(isLoggedIn);
      if (isLoggedIn == true) {
        Navigator.pushNamed(context, "/dashboard");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 1024) {
            return MobileMode();
          } else {
            return DesktopMode();
          }
        },
      ),
    );
  }
}

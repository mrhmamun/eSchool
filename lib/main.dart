import 'package:eschool/view/home/dashboard_page.dart';
import 'package:eschool/view/login/login_page.dart';
import 'package:eschool/view/signup/signup.dart';
import 'package:eschool/view/user/add_a_user.dart';
import 'package:eschool/view/user/all_users.dart';
import 'package:eschool/view/user/edit_user_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  setPathUrlStrategy();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eSchool',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/dashboard': (context) => DashboardPage(),
          '/addauser': (context) => AddAUser(),
          '/allusers': (context) => AllUsers(),
          '/edituserdetails': (context) => EditUserDetails()
        });
  }
}

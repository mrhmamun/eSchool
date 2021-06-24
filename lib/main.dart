import 'package:eschool/view/admin/home/dashboard_page.dart';
import 'package:eschool/view/admin/subjects/edit_subject_details.dart';
import 'package:eschool/view/admin/user/add_a_user.dart';
import 'package:eschool/view/admin/user/all_users.dart';
import 'package:eschool/view/admin/user/edit_user_details.dart';
import 'package:eschool/view/login/login_page.dart';
import 'package:eschool/view/signup/signup.dart';
import 'package:eschool/view/student/home/student_dashboard.dart';
import 'package:eschool/view/teacher/home/teacher_dashboard_page.dart';
import 'package:eschool/view/teacher/test/edit_test_details.dart';
import 'package:eschool/view/teacher/test/result_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('pt', 'BR')],
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/dashboard': (context) => DashboardPage(),
          '/addauser': (context) => AddAUser(),
          '/allusers': (context) => AllUsers(),
          '/edituserdetails': (context) => EditUserDetails(),
          '/edit-subject-details': (context) => EditSubjectDetails(),
          '/teacher-dashboard-page': (context) => TeacherDashboardPage(),
          '/edit-test-details': (context) => EditTestDetails(),
          '/result-details': (context) => ResultDetails(),
          '/student-dashboard': (context) => StudentDashboard(),
        });
  }
}

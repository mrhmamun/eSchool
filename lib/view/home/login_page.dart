// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eschool/global/globals.dart';
// import 'package:eschool/view/home/my_dashboard_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   var user;
//
//   GlobalKey<ScaffoldState> _scafoldkey = GlobalKey();
//   // var isLoggedin = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SchedulerBinding.instance?.addPostFrameCallback((_) async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var isLoggedin = prefs.getBool('isLoggedin');
//       if (isLoggedin == true) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => MyDashboardPage()));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('iJiMo Admin'),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'iJiMo Admin',
//               style: GoogleFonts.vollkorn(
//                 textStyle: TextStyle(fontSize: 60.0, color: Colors.black87),
//               ),
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await _handleSignIn();
//               },
//               child: Container(
//                 height: 60,
//                 width: 260,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage(
//                       'assets/images/icons/google_signin_button.png'),
//                   fit: BoxFit.cover,
//                 )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<User> _handleSignIn() async {
//     try {
//       if (kIsWeb) {
//         GoogleAuthProvider authProvider = GoogleAuthProvider();
//         final UserCredential userCredential =
//             await Globals.auth.signInWithPopup(authProvider);
//         user = userCredential.user;
//       }
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       // final User user = (await Globals.auth.signInWithCredential(credential)).user;
//
//       DocumentSnapshot doc = await Globals.userRef.doc(user?.uid).get();
//
//       if (!doc.exists) {
//         Globals.userRef.doc(user?.uid).set({
//           'uid': user.uid,
//           'email': user.email,
//           'displayName': user.displayName,
//           'userName': user.displayName,
//           'photoUrl': user.photoURL,
//           // 'phoneNumber': user.phoneNumber,
//           // 'userType': "Student",
//           "isAdmin": false,
//           // "category": _categoryValue,
//           // "grade": _gradeValue,
//           // 'localPoint': 0,
//           // 'globalPoint': 0,
//           // 'askedQuestion': [],
//           // 'answeredQuestion': [],
//           // 'favorites': [],
//           // 'lectureWatched': [],
//           // 'streakDays': 0,
//           'isSubscribed': false,
//           'createdAt': FieldValue.serverTimestamp(),
//           'updatedAt': FieldValue.serverTimestamp(),
//           'lastLoggedIn': FieldValue.serverTimestamp(),
//         });
//         doc = await Globals.userRef.doc(user?.uid).get();
//       }
//
//       prefs.setBool("isLoggedin", true);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         Globals.customSnackBar(
//           content: 'User Logged In Successfully!',
//         ),
//       );
//
//       Navigator.pushReplacement(
//           context, CupertinoPageRoute(builder: (context) => MyDashboardPage()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           Globals.customSnackBar(
//             content: 'The account already exists with a different credential.',
//           ),
//         );
//       } else if (e.code == 'invalid-credential') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           Globals.customSnackBar(
//             content: 'Error occurred while accessing credentials. Try again.',
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool("isLoggedin", false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         Globals.customSnackBar(
//           content: 'Error occurred using Google Sign-In. Try again.',
//         ),
//       );
//     }
//
//     return user;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Globals {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  static final CollectionReference? classRef =
      FirebaseFirestore.instance.collection('classes');
  static final CollectionReference? subCategoryRef =
      FirebaseFirestore.instance.collection('subcategory');

  static final CollectionReference? subjectRef =
      FirebaseFirestore.instance.collection('subjects');

  static final CollectionReference? videoRef =
      FirebaseFirestore.instance.collection('videos');
  static final CollectionReference? otherRef =
      FirebaseFirestore.instance.collection('others');

  static final CollectionReference? QuestionRef =
      FirebaseFirestore.instance.collection('questions');

  static Future<DocumentSnapshot> getUid() async {
    await Future.delayed(Duration(seconds: 3));
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    var uid = userRef.doc(firebaseUser?.uid).get();
    return uid;
  }

  static SnackBar customSnackBar({String? content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content.toString(),
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}

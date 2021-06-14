import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ninja/symmetric/aes/aes.dart';

class SignUpForm extends StatefulWidget {
  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  SignUpForm(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();
  String? email;
  String? password;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.only(
                  left: widthSize * 0.05,
                  right: widthSize * 0.05,
                  top: heightSize * widget.paddingTopForm),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Colors.white))),
                TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Email!';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 10),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      labelStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: widthSize * widget.errorFormMessage),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: widthSize * widget.iconFormSize,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.fontSizeTextFormField)),
                SizedBox(height: heightSize * widget.spaceBetweenFields),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Colors.white))),
                TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Password!';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      labelStyle: TextStyle(color: Colors.white),
                      errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: widthSize * widget.errorFormMessage),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: widthSize * widget.iconFormSize,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.fontSizeTextFormField)),
                SizedBox(
                    height: heightSize * widget.spaceBetweenFieldAndButton),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.fromLTRB(
                        widget.widthButton, 15, widget.widthButton, 15),
                    color: Colors.white,
                    onPressed: () async {
                      /*
                      Password-Based Key Derivation Function 2 (PBKDF2) makes it harder for someone to determine your Master Password by making repeated guesses in a brute force attack. 1Password uses PBKDF2 in the process of deriving encryption keys from your Master Password.
                      */
                      setState(() {
                        isLoading = true;
                      });
                      // var hashedPassword =
                      //     Password.hash(password, new PBKDF2());
                      // print(hashedPassword);

                      final aes = AESKey(
                          Uint8List.fromList(List.generate(16, (i) => i)));
                      String hashedPassword = aes.encryptToBase64(password);
                      print(hashedPassword);
                      // String decoded = aes.decryptToUtf8(hashedPassword);
                      // print(decoded);

                      if (_formKey.currentState!.validate()) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: email.toString(),
                                  password: password.toString());
                          var user = userCredential.user;
                          DocumentSnapshot doc =
                              await Globals.userRef.doc(user?.uid).get();
                          if (!doc.exists) {
                            Globals.userRef.doc(user?.uid).set({
                              'uid': user?.uid,
                              'email': user?.email,
                              'firstName': "firstName",
                              'lastName': "lastName",
                              'displayName': "userName",
                              'password': hashedPassword,
                              'userName': user?.email,
                              'bio': "bio",
                              'photoUrl': user?.photoURL,
                              'phoneNumber': "phoneNumber",
                              'userType': "Default",
                              'publicUrl': "url",
                              "isAdmin": false,
                              'createdAt': FieldValue.serverTimestamp(),
                              'updatedAt': FieldValue.serverTimestamp(),
                              'lastLoggedIn': FieldValue.serverTimestamp(),
                            });
                            doc = await Globals.userRef.doc(user?.uid).get();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            Globals.customSnackBar(
                              content: 'User $email Registration Successful!',
                            ),
                          );

                          setState(() {
                            _usernameController.text = "";
                            _passwordController.text = "";
                            isLoading = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              Globals.customSnackBar(
                                content: 'The password provided is too weak.',
                              ),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              Globals.customSnackBar(
                                content:
                                    'The account already exists for that email.',
                              ),
                            );
                            setState(() {
                              _usernameController.text = "";
                              _passwordController.text = "";
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text('SignUp',
                        style: TextStyle(
                            fontSize: widthSize * widget.fontSizeButton,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(41, 187, 255, 1)))),
                SizedBox(height: heightSize * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Already Have an Account?',
                        style: TextStyle(
                            fontSize: widthSize * widget.fontSizeButton,
                            fontFamily: 'Poppins',
                            color: Colors.white)),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('SignIn',
                          style: TextStyle(
                              fontSize: widthSize * widget.fontSizeButton,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
                // Text('Forgot Password?',
                //     style: TextStyle(
                //         fontSize: widthSize * widget.fontSizeForgotPassword,
                //         fontFamily: 'Poppins',
                //         color: Colors.white)),
                SizedBox(height: 10),
              ]))),
    );
  }
}

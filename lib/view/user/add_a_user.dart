import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ninja/symmetric/aes/aes.dart';
import 'package:uuid/uuid.dart';

class AddAUser extends StatefulWidget {
  @override
  _AddAUserState createState() => _AddAUserState();
}

class _AddAUserState extends State<AddAUser> {
  TextEditingController? addUserNameController;
  TextEditingController? addFirstNameController;
  TextEditingController? addLastNameController;
  TextEditingController? addPasswordController;
  TextEditingController? addEmailController;
  TextEditingController? addBioController;
  TextEditingController? addPublicUrlController;
  String? _firstName;
  String? _lastName;
  String? _userName;
  String? _email;
  String? _password;
  String? _bio;
  String? _url;
  String? _thumbImage; //
  String? _userTypeDropdownValue; //
  int? answerIndex;
  int? videoVersionAnswerIndex;
  List<String> _userTypeList = [
    'Admin',
    // 'Super Admin',
    'Student',
    'Teacher',
  ];

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addUserNameController = TextEditingController();
    addFirstNameController = TextEditingController();
    addLastNameController = TextEditingController();
    addPasswordController = TextEditingController();
    addEmailController = TextEditingController();
    addBioController = TextEditingController();
    addPublicUrlController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addUserNameController?.dispose();
    addFirstNameController?.dispose();
    addLastNameController?.dispose();
    addPasswordController?.dispose();
    addEmailController?.dispose();
    addBioController?.dispose();
    addPublicUrlController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'First Name: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addFirstNameController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'Write user first name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _firstName = value;
                                        print(_firstName);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter First!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Last Name: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addLastNameController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'Write user last name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _lastName = value;
                                        print(_lastName);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Last Name!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Username: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addUserNameController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'Write username',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _userName = value;
                                        print(_userName);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your username!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Email: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addEmailController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'User email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _email = value;
                                        print(_email);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Password: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addPasswordController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'User password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _password = value;
                                        print(_password);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your password!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'User Type',
                                        style: TextStyle(color: Colors.black87),
                                      )),
                                    ),
                                    Container(
                                      height: 50,
                                      // width: 300,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          200,

                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text('Select User Type'),
                                          ),
                                          value: _userTypeDropdownValue,
                                          onChanged: (value) {
                                            setState(() {
                                              _userTypeDropdownValue =
                                                  value.toString();
                                            });

                                            if (_userTypeDropdownValue ==
                                                "Admin") {
                                              setState(() {
                                                answerIndex = 0;
                                              });
                                            } else if (_userTypeDropdownValue ==
                                                "Student") {
                                              setState(() {
                                                answerIndex = 1;
                                              });
                                            } else if (_userTypeDropdownValue ==
                                                "Teacher") {
                                              setState(() {
                                                answerIndex = 2;
                                              });
                                            }
                                          },
                                          items: _userTypeList.map((value) {
                                            return new DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: new Text(
                                                  value.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Bio: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 150,
                                    child: TextFormField(
                                      controller: addBioController,
                                      showCursor: true,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        hintText: 'User short Bio',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _bio = value;
                                        print(_bio);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter bio!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Profile Photo: ',
                                        style: TextStyle(color: Colors.black87),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        imagePicker();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            )),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Add a Photo',
                                              style: TextStyle(
                                                  color: Colors.grey.shade700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 20,
                              ),
                              _thumbImage == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Preview: ',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            )),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                )),
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ])
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Image: ',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            )),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                )),
                                            child: Image.network(
                                              _thumbImage.toString(),
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Public Url: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    child: TextFormField(
                                      controller: addPublicUrlController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: 'Add a website or Social Url',
                                        // errorText: validateText(
                                        //     addVideoController?.text, 'URL'),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        // suffix: FloatingActionButton(
                                        //   child: Icon(Icons.add_circle),
                                        //   onPressed: () {},
                                        // ),
                                        // suffixIcon: Icon(Icons.add_circle),
                                      ),
                                      onChanged: (value) {
                                        _url = value;
                                        print(_url);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please add public profile url!';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  if (_firstName == null ||
                                      _firstName!.isEmpty ||
                                      _bio == null ||
                                      _bio!.isEmpty ||
                                      _url == null ||
                                      _url!.isEmpty ||
                                      _thumbImage == null ||
                                      _thumbImage!.isEmpty ||
                                      _userTypeDropdownValue == null ||
                                      _userTypeDropdownValue!.isEmpty ||
                                      _lastName!.isEmpty ||
                                      _lastName == null ||
                                      _email!.isEmpty ||
                                      _email == null ||
                                      _password!.isEmpty ||
                                      _password == null ||
                                      _bio!.isEmpty ||
                                      _bio == null) {
                                    print('Empty Error');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      Globals.customSnackBar(
                                        content:
                                            'Please enter all fields properly!',
                                      ),
                                    );
                                  } else {
                                    // var hashedPassword =
                                    //     Password.hash(_password, new PBKDF2());
                                    // print(hashedPassword);

                                    final aes = AESKey(Uint8List.fromList(
                                        List.generate(16, (i) => i)));
                                    String hashedPassword =
                                        aes.encryptToBase64(_password);
                                    print(hashedPassword);
                                    String decoded =
                                        aes.decryptToUtf8(hashedPassword);
                                    print(decoded);

                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        FirebaseApp app =
                                            await Firebase.initializeApp(
                                                name: 'Secondary',
                                                options:
                                                    Firebase.app().options);

                                        UserCredential userCredential =
                                            await FirebaseAuth.instanceFor(
                                                    app: app)
                                                .createUserWithEmailAndPassword(
                                                    email: _email.toString(),
                                                    password:
                                                        _password.toString());
                                        var user = userCredential.user;
                                        DocumentSnapshot doc = await Globals
                                            .userRef
                                            .doc(user?.uid)
                                            .get();
                                        if (!doc.exists) {
                                          Globals.userRef.doc(user?.uid).set({
                                            'uid': user?.uid,
                                            'email': user?.email,
                                            'firstName': _firstName,
                                            'lastName': _lastName,
                                            'displayName': _userName,
                                            'password': hashedPassword,
                                            'userName': _userName,
                                            'bio': _bio,
                                            'photoUrl': _thumbImage,
                                            'phoneNumber': "phoneNumber",
                                            'userType': _userTypeDropdownValue,
                                            'publicUrl': _url,
                                            "isAdmin": false,
                                            'createdAt':
                                                FieldValue.serverTimestamp(),
                                            'updatedAt':
                                                FieldValue.serverTimestamp(),
                                            'lastLoggedIn':
                                                FieldValue.serverTimestamp(),
                                          });
                                          doc = await Globals.userRef
                                              .doc(user?.uid)
                                              .get();
                                        }

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          Globals.customSnackBar(
                                            content:
                                                'User $_email Registration Successful!',
                                          ),
                                        );

                                        await app.delete();
                                        Future.sync(() => userCredential);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print(
                                              'The password provided is too weak.');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            Globals.customSnackBar(
                                              content:
                                                  'The password provided is too weak.',
                                            ),
                                          );
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          print(
                                              'The account already exists for that email.');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            Globals.customSnackBar(
                                              content:
                                                  'The account already exists for that email.',
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }

                                    setState(() {
                                      isLoading = false;
                                      addFirstNameController?.clear();
                                      addLastNameController?.clear();
                                      addPasswordController?.clear();
                                      addUserNameController?.clear();
                                      addEmailController?.clear();
                                      addBioController?.clear();
                                      addPublicUrlController?.clear();
                                      _thumbImage = null;
                                      _userTypeDropdownValue = null;
                                    });
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => AllVideos()));
                              //   },
                              //   child: Container(
                              //     width: MediaQuery.of(context).size.width,
                              //     height: 50,
                              //     decoration: BoxDecoration(
                              //         color: Colors.indigo,
                              //         borderRadius: BorderRadius.circular(20)),
                              //     child: Center(
                              //         child: Text(
                              //       'All Videos',
                              //       style: TextStyle(color: Colors.white),
                              //     )),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // late String imgUrl;
  //
  // imagePicker() {
  //   var input = FileUploadInputElement()..accept = 'image/*';
  //   FirebaseStorage fs = FirebaseStorage.instance;
  //   input.click();
  //   input.onChange.listen((event) {
  //     final file = input.files!.first;
  //     final reader = FileReader();
  //     reader.readAsDataUrl(file);
  //     reader.onLoadEnd.listen((event) async {
  //       var snapshot = await fs.ref().child('newfile').putBlob(file);
  //       String downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imgUrl = downloadUrl;
  //         print(imgUrl);
  //       });
  //     });
  //   });
  // }

  imagePicker() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      Uint8List uploadFile = result.files.single.bytes!;

      String? fileName = result.files.single.name;
      var uuid = Uuid();

      Reference reference =
          FirebaseStorage.instance.ref('images').child(uuid.v4());

      print(reference);
      print(uuid.v4());

      final UploadTask uploadTask = reference.putData(uploadFile);
      // final UploadTask uploadTask = reference.putData(uploadFile);

      // if (uploadTask.snapshot.state == TaskState.success) {
      //   String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      //   print(downloadUrl);
      //   print('file uploaded');
      // } else {
      //   print("error");
      //

      uploadTask.whenComplete(() async {
        String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
        print(downloadUrl);
        print('file uploaded');
        setState(() {
          _thumbImage = downloadUrl;
        });
      }).catchError((e) {
        print(e);
      });

      print(fileName);
    } else {
      // User canceled the picker
    }
  }

  validateText(String? value, String? field) {
    if (value == null || value.isEmpty) {
      return "$field Field Can't be empty";
    }
    return null;
  }
}

// NewImageUpload

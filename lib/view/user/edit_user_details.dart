import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:password/password.dart';
import 'package:uuid/uuid.dart';

class EditUserDetails extends StatefulWidget {
  var index;
  var uid;
  var firstName;
  var lastName;
  var email;
  var displayName;
  var password;
  var userName;
  var bio;
  var photoUrl;
  var phoneNumber;
  var userType;
  var publicUrl;
  var isAdmin;

  EditUserDetails({
    this.index,
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.displayName,
    this.password,
    this.userName,
    this.bio,
    this.photoUrl,
    this.phoneNumber,
    this.userType,
    this.publicUrl,
    this.isAdmin,
  });

  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
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
    addUserNameController = TextEditingController(text: widget.userName);
    addFirstNameController = TextEditingController(text: widget.firstName);
    addLastNameController = TextEditingController(text: widget.lastName);
    addPasswordController = TextEditingController(text: "*******");
    addEmailController = TextEditingController(text: widget.email);
    addBioController = TextEditingController(text: widget.bio);
    addPublicUrlController = TextEditingController(text: widget.publicUrl);

    _userTypeDropdownValue = widget.userType;
    _thumbImage = widget.photoUrl.toString();

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
            appBar: AppBar(
              title: Text('Edit User Details'),
            ),
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

                                  // if (_firstName == null ||
                                  //     _firstName!.isEmpty ||
                                  //     _bio == null ||
                                  //     _bio!.isEmpty ||
                                  //     _url == null ||
                                  //     _url!.isEmpty ||
                                  //     _thumbImage == null ||
                                  //     _thumbImage!.isEmpty ||
                                  //     _userTypeDropdownValue == null ||
                                  //     _userTypeDropdownValue!.isEmpty ||
                                  //     _lastName!.isEmpty ||
                                  //     _lastName == null ||
                                  //     _email!.isEmpty ||
                                  //     _email == null ||
                                  //     _password!.isEmpty ||
                                  //     _password == null ||
                                  //     _bio!.isEmpty ||
                                  //     _bio == null) {
                                  //   print('Empty Error');
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     Globals.customSnackBar(
                                  //       content:
                                  //           'Please enter all fields properly!',
                                  //     ),
                                  //   );
                                  // } else {
                                  var hashedPassword;
                                  if (_password != null) {
                                    hashedPassword =
                                        Password.hash(_password, new PBKDF2());
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      // FirebaseApp app =
                                      //     await Firebase.initializeApp(
                                      //         name: 'Secondary',
                                      //         options:
                                      //             Firebase.app().options);
                                      //
                                      // UserCredential userCredential =
                                      //     await FirebaseAuth.instanceFor(
                                      //             app: app)
                                      //         .createUserWithEmailAndPassword(
                                      //             email: _email.toString(),
                                      //             password:
                                      //                 _password.toString());
                                      // var user = userCredential.user;
                                      // DocumentSnapshot doc = await Globals
                                      //     .userRef
                                      //     .doc(widget.uid)
                                      //     .get();
                                      // if (!doc.exists) {
                                      Globals.userRef.doc(widget.uid).update({
                                        'uid': widget.uid,
                                        'email': _email == null
                                            ? widget.email
                                            : _email,
                                        'firstName': _firstName == null
                                            ? widget.firstName
                                            : _firstName,
                                        'lastName': _lastName == null
                                            ? widget.lastName
                                            : _lastName,
                                        'displayName': _userName == null
                                            ? widget.displayName
                                            : _userName,
                                        'password': hashedPassword == null
                                            ? widget.password
                                            : hashedPassword,
                                        'userName': _userName == null
                                            ? widget.userName
                                            : _userName,
                                        'bio': _bio == null ? widget.bio : _bio,
                                        'photoUrl': _thumbImage == null
                                            ? widget.photoUrl
                                            : _thumbImage,
                                        'phoneNumber': "phoneNumber",
                                        'userType':
                                            _userTypeDropdownValue == null
                                                ? widget.userType
                                                : _userTypeDropdownValue,
                                        'publicUrl': _url == null
                                            ? widget.publicUrl
                                            : _url,
                                        "isAdmin": widget.isAdmin,
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                        'updatedAt':
                                            FieldValue.serverTimestamp(),
                                        'lastLoggedIn':
                                            FieldValue.serverTimestamp(),
                                      });
                                      // doc = await Globals.userRef
                                      //     .doc(user?.uid)
                                      //     .get();
                                      // }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        Globals.customSnackBar(
                                          content:
                                              'User Details Updated Successful!',
                                        ),
                                      );

                                      Navigator.pushNamed(
                                          context, '/dashboard');

                                      // await app.delete();
                                      // Future.sync(() => userCredential);
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
                                    // addFirstNameController?.clear();
                                    // addLastNameController?.clear();
                                    // addPasswordController?.clear();
                                    // addUserNameController?.clear();
                                    // addEmailController?.clear();
                                    // addBioController?.clear();
                                    // addPublicUrlController?.clear();
                                    // _thumbImage = null;
                                    // _userTypeDropdownValue = null;
                                  });
                                  // }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    'Save',
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

// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eschool/global/globals.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/basic.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:uuid/uuid.dart';
//
// class EditUserDetails extends StatefulWidget {
//   String? url;
//   int? index;
//
//   EditUserDetails({this.url, this.index});
//
//   @override
//   _EditUserDetailsState createState() => _EditUserDetailsState();
// }
//
// class _EditUserDetailsState extends State<EditUserDetails> {
//   final _formKey = GlobalKey<FormState>();
//   GlobalKey<ScaffoldState> _ScafoldKey = GlobalKey();
//   TextEditingController? addVideoController;
//   TextEditingController? addVideoTitleController;
//   TextEditingController? addVideoDescController;
//   String? _addVideo;
//   String? _title;
//   String? _desc;
//   String? _url;
//   String? _categoryValue; // Option 2
//   String? _gradeValue; // Option 2
//   String? _subjectValue; // Option 2
//   String? _topicsValue; // Option 2
//   String? _thumbImage; //
//   String? _videoFor; //
//   int? answerIndex;
//   List<String> _videoForList = [
//     'Beginner',
//     'Intermediate',
//     'Advance',
//   ]; //
//
//   bool isLoading = false;
//
//   Stream getVideos() {
//     var data = Globals.videoRef!
//         .where('url', isEqualTo: widget.url.toString())
//         .snapshots();
//     data.forEach((element) {
//       for (int i = 0; i < element.docs.length; i++) {
//         setState(() {
//           _title = element.docs[i]['title'];
//           _desc = element.docs[i]['desc'];
//           _categoryValue = element.docs[i]['category'];
//           _gradeValue = element.docs[i]['grade'];
//           _subjectValue = element.docs[i]['subject'];
//           _topicsValue = element.docs[i]['topics'];
//           _videoFor = element.docs[i]['videoFor'];
//           _thumbImage = element.docs[i]['imageUrl'];
//           _url = element.docs[i]['url'];
//           print("_title");
//           print(_title);
//         });
//       }
//     }).then((value) {});
//
//     return data;
//   }
//
//   @override
//   void initState() {
//     getVideos();
//     addVideoController = TextEditingController(text: _addVideo);
//     addVideoTitleController = TextEditingController();
//     addVideoDescController = TextEditingController();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     addVideoController?.dispose();
//     addVideoTitleController?.dispose();
//     addVideoDescController?.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//         inAsyncCall: isLoading,
//         child: SafeArea(
//           child: Scaffold(
//             key: _ScafoldKey,
//             appBar: AppBar(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: Text('iJiMo Admin'),
//                   ),
//                 ],
//               ),
//               centerTitle: true,
//               // leading: Container(),
//               actions: [
//                 FutureBuilder<DocumentSnapshot>(
//                   future: Globals.getUid(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<DocumentSnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return Text("Snapshot has error");
//                     } else if (snapshot.connectionState ==
//                         ConnectionState.done) {
//                       var data = snapshot.data?.data();
//                       String uid = data?['uid'];
//                       String displayImage = data?['displayUrl'];
//                       String displayName = data?['displayName'];
//                       return Align(
//                         alignment: Alignment.centerRight,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Center(
//                               child: Container(
//                                 child: Text(
//                                   displayName.toString(),
//                                   style: TextStyle(
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Center(
//                               child: Container(
//                                 child: ClipOval(
//                                   child: Material(
//                                     color: Colors.blue, // button color
//                                     child: InkWell(
//                                       splashColor: Colors.blue, // inkwell color
//                                       child: data?['photoUrl'] == null
//                                           ? Container(
//                                               height: 40,
//                                               width: 40,
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 data?["displayName"]
//                                                     .substring(0, 1),
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                     fontSize: 40),
//                                               ),
//                                             )
//                                           : Image.network(
//                                               data?['photoUrl'],
//                                               fit: BoxFit.cover,
//                                               height: 40,
//                                               width: 40,
//                                             ),
// // onTap: () {
// //   setState(() {
// //     isProfileClicked = true;
// //   });
// // },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     return Center(
//                         child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: CircularProgressIndicator(),
//                     ));
//                   },
//                 ),
//               ],
//             ),
//             body: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Card(
//                       elevation: 10,
//                       clipBehavior: Clip.antiAlias,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         width: MediaQuery.of(context).size.width / 2,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 10,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       bottomLeft: Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     'Title: ',
//                                     style: TextStyle(color: Colors.black87),
//                                   )),
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 2 -
//                                       200,
//                                   height: 50,
//                                   child: TextField(
//                                     controller: TextEditingController()
//                                       ..text = _title.toString(),
//                                     // initialValue: title,
//                                     showCursor: true,
//                                     decoration: InputDecoration(
//                                       hintText: 'Add Video Title',
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         ),
//                                       ),
//                                       // suffix: FloatingActionButton(
//                                       //   child: Icon(Icons.add_circle),
//                                       //   onPressed: () {},
//                                       // ),
//                                       // suffixIcon: Icon(Icons.add_circle),
//                                     ),
//                                     onChanged: (value) {
//                                       _title = value;
//                                       print(_title);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 10,
//                                   height: 200,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       bottomLeft: Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     'Description: ',
//                                     style: TextStyle(color: Colors.black87),
//                                   )),
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 2 -
//                                       200,
//                                   height: 200,
//                                   child: TextField(
//                                     controller: TextEditingController()
//                                       ..text = _desc.toString(),
//                                     showCursor: true,
//                                     maxLines: 10,
//                                     decoration: InputDecoration(
//                                       hintText: 'Add Video Description',
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         ),
//                                       ),
//                                       // suffix: FloatingActionButton(
//                                       //   child: Icon(Icons.add_circle),
//                                       //   onPressed: () {},
//                                       // ),
//                                       // suffixIcon: Icon(Icons.add_circle),
//                                     ),
//                                     onChanged: (value) {
//                                       _desc = value;
//                                       print(_desc);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Category: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 2 -
//                                             200,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         )),
//                                     child: StreamBuilder(
//                                       stream: Globals.categoryRef?.snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<QuerySnapshot>
//                                               snapshot) {
//                                         print(snapshot.data?.docs.length);
//                                         if (snapshot.hasError) {
//                                           return Text('Something went wrong');
//                                         }
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Text("Loading");
//                                         }
//                                         return DropdownButtonHideUnderline(
//                                           child: DropdownButton(
//                                             hint: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5),
//                                               child: Text(
//                                                   'Please choose a Category'),
//                                             ), // Not necessary for Option 1
//                                             value: _categoryValue,
//                                             onChanged: (newValue) {
//                                               setState(() {
//                                                 _categoryValue =
//                                                     newValue.toString();
//                                               });
//                                             },
//                                             items: snapshot.data!.docs
//                                                 .map((location) {
//                                               return DropdownMenuItem(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 5),
//                                                   child: new Text(
//                                                       location['category']
//                                                           .toString()),
//                                                 ),
//                                                 value: location['category']
//                                                     .toString(),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Grade: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 2 -
//                                             200,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         )),
//                                     child: StreamBuilder(
//                                       stream: Globals.videoRef?.snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<QuerySnapshot>
//                                               snapshot) {
//                                         print(snapshot.data?.docs.length);
//                                         if (snapshot.hasError) {
//                                           return Text('Something went wrong');
//                                         }
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Text("Loading");
//                                         }
//                                         return DropdownButtonHideUnderline(
//                                           child: DropdownButton(
//                                             hint: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5),
//                                               child:
//                                                   Text('Please choose a Grade'),
//                                             ), // Not necessary for Option 1
//                                             value: _gradeValue,
//                                             onChanged: (newValue) {
//                                               setState(() {
//                                                 _gradeValue =
//                                                     newValue.toString();
//                                               });
//                                             },
//                                             items: snapshot.data!.docs
//                                                 .map((location) {
//                                               return DropdownMenuItem(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 5),
//                                                   child: new Text(
//                                                       location['grade']
//                                                           .toString()),
//                                                 ),
//                                                 value: location['grade']
//                                                     .toString(),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Subject: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 2 -
//                                             200,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         )),
//                                     child: StreamBuilder(
//                                       stream: Globals.subjectRef?.snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<QuerySnapshot>
//                                               snapshot) {
//                                         print(snapshot.data?.docs.length);
//                                         if (snapshot.hasError) {
//                                           return Text('Something went wrong');
//                                         }
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Text("Loading");
//                                         }
//                                         return DropdownButtonHideUnderline(
//                                           child: DropdownButton(
//                                             hint: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5),
//                                               child: Text(
//                                                   'Please choose a Subject'),
//                                             ), // Not necessary for Option 1
//                                             value: _subjectValue,
//                                             onChanged: (newValue) {
//                                               setState(() {
//                                                 _subjectValue =
//                                                     newValue.toString();
//                                               });
//                                             },
//                                             items: snapshot.data!.docs
//                                                 .map((location) {
//                                               return DropdownMenuItem(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 5),
//                                                   child: new Text(
//                                                       location['subject']
//                                                           .toString()),
//                                                 ),
//                                                 value: location['subject']
//                                                     .toString(),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Topics: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 2 -
//                                             200,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         )),
//                                     child: StreamBuilder(
//                                       stream: Globals.videoRef?.snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<QuerySnapshot>
//                                               snapshot) {
//                                         print(snapshot.data?.docs.length);
//                                         if (snapshot.hasError) {
//                                           return Center(
//                                               child:
//                                                   Text('Something went wrong'));
//                                         }
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Center(child: Text("Loading"));
//                                         }
//                                         return DropdownButtonHideUnderline(
//                                           child: DropdownButton(
//                                             hint: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5),
//                                               child: Text(
//                                                   'Please choose a Topics'),
//                                             ), // Not necessary for Option 1
//                                             value: _topicsValue,
//                                             onChanged: (newValue) {
//                                               setState(() {
//                                                 _topicsValue =
//                                                     newValue.toString();
//                                               });
//                                             },
//                                             items: snapshot.data!.docs
//                                                 .map((location) {
//                                               return DropdownMenuItem(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 5),
//                                                   child: new Text(
//                                                       location['topics']
//                                                           .toString()),
//                                                 ),
//                                                 value: location['topics']
//                                                     .toString(),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Targeted User: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   Container(
//                                     height: 50,
//                                     // width: 300,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2 -
//                                             200,
//
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         )),
//                                     child: DropdownButtonHideUnderline(
//                                       child: new DropdownButton<String>(
//                                         hint: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 5),
//                                           child: Text('Select User Type'),
//                                         ),
//                                         value: _videoFor,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _videoFor = value.toString();
//                                           });
//
//                                           if (_videoFor == "Beginner") {
//                                             setState(() {
//                                               answerIndex = 1;
//                                             });
//                                           } else if (_videoFor ==
//                                               "Intermediate") {
//                                             setState(() {
//                                               answerIndex = 2;
//                                             });
//                                           } else if (_videoFor == "Advance") {
//                                             setState(() {
//                                               answerIndex = 3;
//                                             });
//                                           }
//
//                                           print(value);
//                                           print(answerIndex);
//                                         },
//                                         items: _videoForList.map((value) {
//                                           return new DropdownMenuItem<String>(
//                                             value: value.toString(),
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5),
//                                               child: new Text(
//                                                 value.toString(),
//                                                 style: TextStyle(
//                                                     color: Colors.black87),
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 10,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         bottomLeft: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       'Thumbnail: ',
//                                       style: TextStyle(color: Colors.black87),
//                                     )),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () async {
//                                       await imagePicker();
//                                     },
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width /
//                                               2 -
//                                           200,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Colors.grey, width: 1),
//                                           borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(20),
//                                             bottomRight: Radius.circular(20),
//                                           )),
//                                       child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 8.0),
//                                           child: Text(
//                                             'Add a Thumbnail',
//                                             style: TextStyle(
//                                                 color: Colors.grey.shade700),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             _thumbImage == null
//                                 ? Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                         Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               10,
//                                           height: 50,
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade300,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(20),
//                                               bottomLeft: Radius.circular(20),
//                                             ),
//                                           ),
//                                           child: Center(
//                                               child: Text(
//                                             'Preview: ',
//                                             style: TextStyle(
//                                                 color: Colors.black87),
//                                           )),
//                                         ),
//                                         Container(
//                                           width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   2 -
//                                               200,
//                                           height: 200,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: Colors.grey, width: 1),
//                                               borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(20),
//                                                 bottomRight:
//                                                     Radius.circular(20),
//                                               )),
//                                           child: Center(
//                                             child: CircularProgressIndicator(),
//                                           ),
//                                         ),
//                                       ])
//                                 : Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                         Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               10,
//                                           height: 50,
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade300,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(20),
//                                               bottomLeft: Radius.circular(20),
//                                             ),
//                                           ),
//                                           child: Center(
//                                               child: Text(
//                                             'Image: ',
//                                             style: TextStyle(
//                                                 color: Colors.black87),
//                                           )),
//                                         ),
//                                         Container(
//                                           width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   2 -
//                                               200,
//                                           height: 200,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: Colors.grey, width: 1),
//                                               borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(20),
//                                                 bottomRight:
//                                                     Radius.circular(20),
//                                               )),
//                                           child: Image.network(
//                                             _thumbImage.toString(),
//                                             width: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                     2 -
//                                                 200,
//                                             height: 200,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ]),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 10,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       bottomLeft: Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     'URL: ',
//                                     style: TextStyle(color: Colors.black87),
//                                   )),
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width / 2 -
//                                       200,
//                                   height: 50,
//                                   child: TextField(
//                                     controller: TextEditingController()
//                                       ..text = _url.toString(),
//                                     showCursor: true,
//                                     decoration: InputDecoration(
//                                       hintText: 'Add a Yt Video Url',
//                                       // errorText: validateText(
//                                       //     addVideoController?.text, 'URL'),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(20),
//                                           bottomRight: Radius.circular(20),
//                                         ),
//                                       ),
//                                       // suffix: FloatingActionButton(
//                                       //   child: Icon(Icons.add_circle),
//                                       //   onPressed: () {},
//                                       // ),
//                                       // suffixIcon: Icon(Icons.add_circle),
//                                     ),
//                                     onChanged: (value) {
//                                       _url = value;
//                                       print(_url);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   isLoading = true;
//                                 });
//
//                                 if (_title == null ||
//                                     _title!.isEmpty ||
//                                     _desc == null ||
//                                     _desc!.isEmpty ||
//                                     _categoryValue == null ||
//                                     _categoryValue!.isEmpty ||
//                                     _gradeValue == null ||
//                                     _gradeValue!.isEmpty ||
//                                     _subjectValue == null ||
//                                     _subjectValue!.isEmpty ||
//                                     _url == null ||
//                                     _url!.isEmpty ||
//                                     _thumbImage == null ||
//                                     _thumbImage!.isEmpty ||
//                                     _videoFor == null ||
//                                     _videoFor!.isEmpty ||
//                                     _topicsValue == null ||
//                                     _topicsValue!.isEmpty) {
//                                   print('Empty Error');
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     Globals.customSnackBar(
//                                       content:
//                                           'Please enter all fields properly!',
//                                     ),
//                                   );
//                                 } else {
//                                   Globals.videoRef!
//                                       .where('url', isEqualTo: widget.url)
//                                       .get()
//                                       .then((value) {
//                                     value.docs.forEach((element) {
//                                       element.reference.update({
//                                         'category': _categoryValue,
//                                         'grade': _gradeValue,
//                                         'subject': _subjectValue,
//                                         'title': _title,
//                                         'desc': _desc,
//                                         'url': _url,
//                                         'imageUrl': _thumbImage,
//                                         'videoFor': _videoFor,
//                                         'topics': _topicsValue,
//                                       }).then((value) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           Globals.customSnackBar(
//                                             content:
//                                                 'Video Saved Successfully!',
//                                           ),
//                                         );
//                                         Future.delayed(Duration(seconds: 3));
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                         Navigator.pop(context);
//                                       });
//                                     });
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     color: Colors.indigo,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 child: Center(
//                                     child: Text(
//                                   'Save',
//                                   style: TextStyle(color: Colors.white),
//                                 )),
//                               ),
//                             ),
//                             // SizedBox(
//                             //   height: 10,
//                             // ),
//                             // InkWell(
//                             //   onTap: () {
//                             //     Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //             builder: (context) => AllVideos()));
//                             //   },
//                             //   child: Container(
//                             //     width: MediaQuery.of(context).size.width,
//                             //     height: 50,
//                             //     decoration: BoxDecoration(
//                             //         color: Colors.indigo,
//                             //         borderRadius: BorderRadius.circular(20)),
//                             //     child: Center(
//                             //         child: Text(
//                             //       'All Videos',
//                             //       style: TextStyle(color: Colors.white),
//                             //     )),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
//
//   // late String imgUrl;
//   //
//   // imagePicker() {
//   //   var input = FileUploadInputElement()..accept = 'image/*';
//   //   FirebaseStorage fs = FirebaseStorage.instance;
//   //   input.click();
//   //   input.onChange.listen((event) {
//   //     final file = input.files!.first;
//   //     final reader = FileReader();
//   //     reader.readAsDataUrl(file);
//   //     reader.onLoadEnd.listen((event) async {
//   //       var snapshot = await fs.ref().child('newfile').putBlob(file);
//   //       String downloadUrl = await snapshot.ref.getDownloadURL();
//   //       setState(() {
//   //         imgUrl = downloadUrl;
//   //         print(imgUrl);
//   //       });
//   //     });
//   //   });
//   // }
//
//   imagePicker() async {
//     FilePickerResult? result;
//
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'png', 'jpeg'],
//     );
//
//     if (result != null) {
//       Uint8List uploadFile = result.files.single.bytes!;
//
//       String? fileName = result.files.single.name;
//       var uuid = Uuid();
//
//       Reference reference =
//           FirebaseStorage.instance.ref('images').child(uuid.v4());
//
//       print(reference);
//       print(uuid.v4());
//
//       final UploadTask uploadTask = reference.putData(uploadFile);
//       // final UploadTask uploadTask = reference.putData(uploadFile);
//
//       // if (uploadTask.snapshot.state == TaskState.success) {
//       //   String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
//       //   print(downloadUrl);
//       //   print('file uploaded');
//       // } else {
//       //   print("error");
//       //
//
//       uploadTask.whenComplete(() async {
//         String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
//         print(downloadUrl);
//         print('file uploaded');
//         setState(() {
//           _thumbImage = downloadUrl;
//         });
//       }).catchError((e) {
//         print(e);
//       });
//
//       print(fileName);
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   validateText(String? value, String? field) {
//     if (value == null || value.isEmpty) {
//       return "$field Field Can't be empty";
//     }
//     return null;
//   }
// }

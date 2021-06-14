import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:eschool/view/user/edit_user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ninja/symmetric/aes/aes.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  String? _userTypeDropdownValue;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var email;
  int answerIndex = 0;
  List<String> _userTypeList = [
    'Admin',
    // 'Super Admin',
    'Student',
    'Teacher',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
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
                                  'User Type: ',
                                  style: TextStyle(color: Colors.black87),
                                )),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                                child: DropdownButtonHideUnderline(
                                  child: new DropdownButton<String>(
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text('Select User Type'),
                                    ),
                                    value: _userTypeDropdownValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _userTypeDropdownValue =
                                            value.toString();
                                      });

                                      if (_userTypeDropdownValue == "Admin") {
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
                                          padding:
                                              const EdgeInsets.only(left: 5),
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
                      ),
                    ),
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Globals.userRef
                              .where('userType',
                                  isEqualTo: _userTypeDropdownValue)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            print(snapshot.data?.docs.length);
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            return new ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = snapshot.data!.docs[index];
                                var newIndex = index + 1;
                                email = snapshot.data!.docs[index]['email'];
                                var uid = snapshot.data!.docs[index]['uid'];
                                var firstName =
                                    snapshot.data!.docs[index]['firstName'];
                                var lastName =
                                    snapshot.data!.docs[index]['lastName'];
                                var displayName =
                                    snapshot.data!.docs[index]['displayName'];
                                var password =
                                    snapshot.data!.docs[index]['password'];
                                var userName =
                                    snapshot.data!.docs[index]['userName'];
                                var bio = snapshot.data!.docs[index]['bio'];
                                var photoUrl =
                                    snapshot.data!.docs[index]['photoUrl'];
                                var phoneNumber =
                                    snapshot.data!.docs[index]['phoneNumber'];
                                var userType =
                                    snapshot.data!.docs[index]['userType'];
                                var publicUrl =
                                    snapshot.data!.docs[index]['publicUrl'];
                                var isAdmin =
                                    snapshot.data!.docs[index]['isAdmin'];
                                return Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                200,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Text(
                                              "   " +
                                                  newIndex.toString() +
                                                  ".  ",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                // fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Text(
                                              email,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              // setState(() {
                                              // isLoading = true;
                                              // editCategory = snapshot.data!
                                              //     .docs[index]['category'];
                                              // });

                                              // AwesomeDialog(
                                              //     context: _scaffoldKey
                                              //         .currentContext,
                                              //     animType: AnimType.SCALE,
                                              //     dialogType: DialogType.INFO,
                                              //     width: MediaQuery.of(context)
                                              //             .size
                                              //             .width /
                                              //         2,
                                              //     body: Container(
                                              //       // height: 300,
                                              //       // width: 300,
                                              //       padding: EdgeInsets.all(5),
                                              //       decoration: BoxDecoration(
                                              //           color: Colors.white,
                                              //           borderRadius:
                                              //               BorderRadius.all(
                                              //                   Radius.circular(
                                              //                       15)),
                                              //           border: Border.all(
                                              //               width: 3,
                                              //               color: Colors.white,
                                              //               style: BorderStyle
                                              //                   .solid)),
                                              //       child: Column(
                                              //         children: [
                                              //           SizedBox(
                                              //             height: 10,
                                              //           ),
                                              //           Container(
                                              //             height: 50,
                                              //             child: TextFormField(
                                              //               // controller: editCategoryController,
                                              //               initialValue:
                                              //                   editCategory,
                                              //               showCursor: true,
                                              //               decoration:
                                              //                   InputDecoration(
                                              //                 hintText:
                                              //                     'Edit Category',
                                              //                 border: OutlineInputBorder(
                                              //                     borderRadius:
                                              //                         BorderRadius
                                              //                             .circular(
                                              //                                 20)),
                                              //               ),
                                              //               onChanged: (value) {
                                              //                 editCategory =
                                              //                     value;
                                              //                 print(
                                              //                     editCategory);
                                              //               },
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     btnOkOnPress: () {
                                              //       print('Button Tapped');
                                              //       print(editCategory);
                                              //
                                              //       Globals.categoryRef
                                              //           ?.doc(snapshot.data!
                                              //                   .docs[index]
                                              //               ['category'])
                                              //           .delete()
                                              //           .then((value) {
                                              //         Globals.categoryRef
                                              //             ?.doc(editCategory)
                                              //             .set({
                                              //           "category": editCategory
                                              //         }).then((value) {
                                              //           ScaffoldMessenger.of(
                                              //                   context)
                                              //               .showSnackBar(
                                              //             Globals
                                              //                 .customSnackBar(
                                              //               content:
                                              //                   'Category Edited Successfully!',
                                              //             ),
                                              //           );
                                              //         });
                                              //       });
                                              //
                                              //       // Globals.categoryRef
                                              //       //     ?.doc()
                                              //       //     .update({
                                              //       //   'category': editCategory
                                              //       // }).then((value) {
                                              //       //   ScaffoldMessenger.of(
                                              //       //           context)
                                              //       //       .showSnackBar(
                                              //       //     Globals.customSnackBar(
                                              //       //       content:
                                              //       //           'Category Edited Successfully!',
                                              //       //     ),
                                              //       //   );
                                              //       // });
                                              //     },
                                              //     btnOkText: 'Save')
                                              //   ..show();

                                              // Navigator.pop(context);

                                              // setState(() {
                                              //   isLoading = false;
                                              // });

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditUserDetails(
                                                            index: index,
                                                            uid: uid,
                                                            email: email,
                                                            firstName:
                                                                firstName,
                                                            lastName: lastName,
                                                            displayName:
                                                                displayName,
                                                            password: password,
                                                            userName: userName,
                                                            bio: bio,
                                                            photoUrl: photoUrl,
                                                            phoneNumber:
                                                                phoneNumber,
                                                            userType: userType,
                                                            publicUrl:
                                                                publicUrl,
                                                            isAdmin: isAdmin,
                                                          )));
                                            },
                                            child: Container(
                                              // width: 100,
                                              height: 50,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),

                                              child: Center(
                                                  child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              Globals.userRef
                                                  ?.get()
                                                  .then((value) async {
                                                if (item.exists) {
                                                  item.reference.delete();
                                                  final aes = AESKey(
                                                      Uint8List.fromList(
                                                          List.generate(
                                                              16, (i) => i)));
                                                  // String hashedPassword = aes.encryptToBase64(password);
                                                  // print(hashedPassword);
                                                  String decoded = aes
                                                      .decryptToUtf8(password);
                                                  print(decoded);
                                                  FirebaseApp app =
                                                      await Firebase
                                                          .initializeApp(
                                                              name: 'Secondary',
                                                              options:
                                                                  Firebase.app()
                                                                      .options);

                                                  UserCredential
                                                      userCredential =
                                                      await FirebaseAuth
                                                              .instanceFor(
                                                                  app: app)
                                                          .signInWithEmailAndPassword(
                                                              email: email
                                                                  .toString(),
                                                              password: decoded
                                                                  .toString());
                                                  var user = userCredential
                                                      .user!
                                                      .delete();
                                                  app.delete();
                                                }

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  Globals.customSnackBar(
                                                    content:
                                                        'User Removed Successfully!',
                                                  ),
                                                );
                                              });

                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              // width: 100,
                                              height: 50,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                  child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },

                              // children: snapshot.data!.docs
                              //     .map((DocumentSnapshot document) {
                              //   return new ListTile(
                              //     title: new Text(document.data()?['category']),
                              //     // subtitle: new Text(document.data()?['subject']),
                              //   );
                              // }).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

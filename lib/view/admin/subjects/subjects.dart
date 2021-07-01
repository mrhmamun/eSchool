import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:eschool/view/admin/subjects/edit_subject_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  TextEditingController? addSubjectController;
  TextEditingController? editSubjectController;
  String? addSubject;
  String? editSubject;
  String? _classValue;
  String? _teacherValue;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var newSubject;
  var editClass;
  var editTeacher;

  var _class;
  var _teacher;

  @override
  void initState() {
    addSubjectController = TextEditingController(text: addSubject);
    editSubjectController = TextEditingController();
    // editSubjectController = TextEditingController(text: editSubject);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addSubjectController?.dispose();
    editSubjectController?.dispose();
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
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
                                    'Subject: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextFormField(
                                    controller: addSubjectController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add a Subject',
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
                                      addSubject = value;
                                      print(addSubject);
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
                                      'Class: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    child: StreamBuilder(
                                      stream: Globals.classRef?.snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        // print(
                                        //     snapshot.data?.docs.length);
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text('Something went wrong'),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(child: Text("Loading"));
                                        }

                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child:
                                                  Text('Please Assign a Class'),
                                            ), // Not necessary for Option 1
                                            value: _classValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _classValue =
                                                    newValue.toString();
                                              });
                                            },
                                            items: snapshot.data!.docs
                                                .map((location) {
                                              print(location['class']);
                                              return DropdownMenuItem(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: new Text(
                                                      location['class']
                                                          .toString()),
                                                ),
                                                value: location['class']
                                                    .toString(),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
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
                                      'Teacher: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    child: StreamBuilder(
                                      stream: Globals.userRef
                                          .where('userType',
                                              isEqualTo: 'Teacher')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        // print(
                                        //     snapshot.data?.docs.length);
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text('Something went wrong'),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(child: Text("Loading"));
                                        }

                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                  'Please Assign a Teacher'),
                                            ), // Not necessary for Option 1
                                            value: _teacherValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _teacherValue =
                                                    newValue.toString();
                                              });
                                            },
                                            items: snapshot.data!.docs
                                                .map((location) {
                                              print(location['displayName']);
                                              return DropdownMenuItem(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: new Text(
                                                      location['displayName']
                                                          .toString()),
                                                ),
                                                value: location['displayName']
                                                    .toString(),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });

                                if (addSubject == null ||
                                    addSubject!.isEmpty ||
                                    _teacherValue == null ||
                                    _teacherValue!.isEmpty ||
                                    _classValue == null ||
                                    _classValue!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content:
                                          "Please enter all fields properly!",
                                    ),
                                  );
                                } else {
                                  Globals.subjectRef?.doc(addSubject).set({
                                    'subject': addSubject,
                                    "class": _classValue,
                                    'teacher': _teacherValue,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      Globals.customSnackBar(
                                        content:
                                            'Subject $addSubject Added Successfully!',
                                      ),
                                    );
                                  });
                                }

                                setState(() {
                                  addSubjectController?.clear();
                                  _classValue = null;
                                  _teacherValue = null;
                                  isLoading = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
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
                          ],
                        ),
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
                          stream: Globals.subjectRef?.snapshots(),
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
                                print(snapshot.data!.docs[index]['subject']);
                                var item = snapshot.data!.docs[index];
                                print(item);
                                editSubject =
                                    snapshot.data!.docs[index]['subject'];
                                editClass = snapshot.data!.docs[index]['class'];
                                editTeacher =
                                    snapshot.data!.docs[index]['teacher'];

                                print(newSubject);
                                var newIndex = index + 1;
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
                                                180,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Text(
                                              "   " +
                                                  newIndex.toString() +
                                                  ".  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ['subject'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "-" +
                                                  snapshot.data!.docs[index]
                                                      ['class'] +
                                                  "-",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ['teacher'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditSubjectDetails(
                                                              editSubject:
                                                                  editSubject,
                                                              editClass:
                                                                  editClass,
                                                              editTeacher:
                                                                  editTeacher)));
                                              // setState(() {
                                              //   isLoading = true;
                                              //   editSubject = sqnapshot.data!
                                              //       .docs[index]['subject'];
                                              //   _class = snapshot
                                              //       .data!.docs[index]['class'];
                                              //   _teacher = snapshot.data!
                                              //       .docs[index]['teacher'];
                                              // });
                                              //
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
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .start,
                                              //         children: [
                                              //           SizedBox(
                                              //             height: 20,
                                              //           ),
                                              //           Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .spaceBetween,
                                              //             children: [
                                              //               Container(
                                              //                 width: MediaQuery.of(
                                              //                             context)
                                              //                         .size
                                              //                         .width /
                                              //                     10,
                                              //                 height: 50,
                                              //                 decoration:
                                              //                     BoxDecoration(
                                              //                   color: Colors
                                              //                       .grey
                                              //                       .shade300,
                                              //                   borderRadius:
                                              //                       BorderRadius
                                              //                           .only(
                                              //                     topLeft: Radius
                                              //                         .circular(
                                              //                             20),
                                              //                     bottomLeft: Radius
                                              //                         .circular(
                                              //                             20),
                                              //                   ),
                                              //                 ),
                                              //                 child: Center(
                                              //                     child: Text(
                                              //                   'Subject: ',
                                              //                   style: TextStyle(
                                              //                       color: Colors
                                              //                           .black87),
                                              //                 )),
                                              //               ),
                                              //               Container(
                                              //                 width: MediaQuery.of(
                                              //                                 context)
                                              //                             .size
                                              //                             .width /
                                              //                         2 -
                                              //                     300,
                                              //                 height: 50,
                                              //                 child:
                                              //                     TextFormField(
                                              //                   // controller: addSubjectController,
                                              //                   showCursor:
                                              //                       true,
                                              //                   initialValue:
                                              //                       editSubject,
                                              //                   decoration:
                                              //                       InputDecoration(
                                              //                     hintText:
                                              //                         'Edit Subject',
                                              //                     border:
                                              //                         OutlineInputBorder(
                                              //                       borderRadius:
                                              //                           BorderRadius
                                              //                               .only(
                                              //                         topRight:
                                              //                             Radius.circular(
                                              //                                 20),
                                              //                         bottomRight:
                                              //                             Radius.circular(
                                              //                                 20),
                                              //                       ),
                                              //                     ),
                                              //                     // suffix: FloatingActionButton(
                                              //                     //   child: Icon(Icons.add_circle),
                                              //                     //   onPressed: () {},
                                              //                     // ),
                                              //                     // suffixIcon: Icon(Icons.add_circle),
                                              //                   ),
                                              //                   onChanged:
                                              //                       (value) {
                                              //                     editSubject =
                                              //                         value;
                                              //                     print(
                                              //                         editSubject);
                                              //                   },
                                              //                   validator:
                                              //                       (value) {
                                              //                     if (value!
                                              //                         .isEmpty) {
                                              //                       return 'Please Enter First!';
                                              //                     }
                                              //                   },
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //           SizedBox(
                                              //             height: 20,
                                              //           ),
                                              //           Row(
                                              //               mainAxisAlignment:
                                              //                   MainAxisAlignment
                                              //                       .spaceBetween,
                                              //               children: [
                                              //                 Container(
                                              //                   width: MediaQuery.of(
                                              //                               context)
                                              //                           .size
                                              //                           .width /
                                              //                       10,
                                              //                   height: 50,
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                     color: Colors
                                              //                         .grey
                                              //                         .shade300,
                                              //                     borderRadius:
                                              //                         BorderRadius
                                              //                             .only(
                                              //                       topLeft: Radius
                                              //                           .circular(
                                              //                               20),
                                              //                       bottomLeft:
                                              //                           Radius.circular(
                                              //                               20),
                                              //                     ),
                                              //                   ),
                                              //                   child: Center(
                                              //                       child: Text(
                                              //                     'Class: ',
                                              //                     style: TextStyle(
                                              //                         color: Colors
                                              //                             .black87),
                                              //                   )),
                                              //                 ),
                                              //                 Container(
                                              //                   width: MediaQuery.of(context)
                                              //                               .size
                                              //                               .width /
                                              //                           2 -
                                              //                       300,
                                              //                   height: 50,
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                           border: Border.all(
                                              //                               color: Colors
                                              //                                   .grey,
                                              //                               width:
                                              //                                   1),
                                              //                           borderRadius:
                                              //                               BorderRadius.only(
                                              //                             topRight:
                                              //                                 Radius.circular(20),
                                              //                             bottomRight:
                                              //                                 Radius.circular(20),
                                              //                           )),
                                              //                   child:
                                              //                       StreamBuilder(
                                              //                     stream: Globals
                                              //                         .classRef
                                              //                         ?.snapshots(),
                                              //                     builder: (BuildContext
                                              //                             context,
                                              //                         AsyncSnapshot<
                                              //                                 QuerySnapshot>
                                              //                             snapshot) {
                                              //                       // print(
                                              //                       //     snapshot.data?.docs.length);
                                              //                       if (snapshot
                                              //                           .hasError) {
                                              //                         return Center(
                                              //                           child: Text(
                                              //                               'Something went wrong'),
                                              //                         );
                                              //                       }
                                              //                       if (snapshot
                                              //                               .connectionState ==
                                              //                           ConnectionState
                                              //                               .waiting) {
                                              //                         return Center(
                                              //                             child:
                                              //                                 Text("Loading"));
                                              //                       }
                                              //
                                              //                       return DropdownButtonHideUnderline(
                                              //                         child:
                                              //                             DropdownButton(
                                              //                           hint:
                                              //                               Padding(
                                              //                             padding:
                                              //                                 const EdgeInsets.only(left: 5),
                                              //                             child:
                                              //                                 Text('Please Assign a Class'),
                                              //                           ), // Not necessary for Option 1
                                              //                           value:
                                              //                               _class,
                                              //                           onChanged:
                                              //                               (newValue) {
                                              //                             setState(
                                              //                                 () {
                                              //                               _class =
                                              //                                   newValue.toString();
                                              //                             });
                                              //                           },
                                              //                           items: snapshot
                                              //                               .data!
                                              //                               .docs
                                              //                               .map((location) {
                                              //                             print(
                                              //                                 location['class']);
                                              //                             return DropdownMenuItem(
                                              //                               child:
                                              //                                   Padding(
                                              //                                 padding: const EdgeInsets.only(left: 5),
                                              //                                 child: new Text(location['class'].toString()),
                                              //                               ),
                                              //                               value:
                                              //                                   location['class'].toString(),
                                              //                             );
                                              //                           }).toList(),
                                              //                         ),
                                              //                       );
                                              //                     },
                                              //                   ),
                                              //                 ),
                                              //               ]),
                                              //           SizedBox(
                                              //             height: 20,
                                              //           ),
                                              //           Row(
                                              //               mainAxisAlignment:
                                              //                   MainAxisAlignment
                                              //                       .spaceBetween,
                                              //               children: [
                                              //                 Container(
                                              //                   width: MediaQuery.of(
                                              //                               context)
                                              //                           .size
                                              //                           .width /
                                              //                       10,
                                              //                   height: 50,
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                     color: Colors
                                              //                         .grey
                                              //                         .shade300,
                                              //                     borderRadius:
                                              //                         BorderRadius
                                              //                             .only(
                                              //                       topLeft: Radius
                                              //                           .circular(
                                              //                               20),
                                              //                       bottomLeft:
                                              //                           Radius.circular(
                                              //                               20),
                                              //                     ),
                                              //                   ),
                                              //                   child: Center(
                                              //                       child: Text(
                                              //                     'Teacher: ',
                                              //                     style: TextStyle(
                                              //                         color: Colors
                                              //                             .black87),
                                              //                   )),
                                              //                 ),
                                              //                 Container(
                                              //                   width: MediaQuery.of(context)
                                              //                               .size
                                              //                               .width /
                                              //                           2 -
                                              //                       300,
                                              //                   height: 50,
                                              //                   decoration:
                                              //                       BoxDecoration(
                                              //                           border: Border.all(
                                              //                               color: Colors
                                              //                                   .grey,
                                              //                               width:
                                              //                                   1),
                                              //                           borderRadius:
                                              //                               BorderRadius.only(
                                              //                             topRight:
                                              //                                 Radius.circular(20),
                                              //                             bottomRight:
                                              //                                 Radius.circular(20),
                                              //                           )),
                                              //                   child:
                                              //                       StreamBuilder(
                                              //                     stream: Globals
                                              //                         .userRef
                                              //                         ?.where(
                                              //                             'userType',
                                              //                             isEqualTo:
                                              //                                 'Teacher')
                                              //                         .snapshots(),
                                              //                     builder: (BuildContext
                                              //                             context,
                                              //                         AsyncSnapshot<
                                              //                                 QuerySnapshot>
                                              //                             snapshot) {
                                              //                       // print(
                                              //                       //     snapshot.data?.docs.length);
                                              //                       if (snapshot
                                              //                           .hasError) {
                                              //                         return Center(
                                              //                           child: Text(
                                              //                               'Something went wrong'),
                                              //                         );
                                              //                       }
                                              //                       if (snapshot
                                              //                               .connectionState ==
                                              //                           ConnectionState
                                              //                               .waiting) {
                                              //                         return Center(
                                              //                             child:
                                              //                                 Text("Loading"));
                                              //                       }
                                              //
                                              //                       return DropdownButtonHideUnderline(
                                              //                         child:
                                              //                             DropdownButton(
                                              //                           hint:
                                              //                               Padding(
                                              //                             padding:
                                              //                                 const EdgeInsets.only(left: 5),
                                              //                             child:
                                              //                                 Text('Please Assign a Teacher'),
                                              //                           ), // Not necessary for Option 1
                                              //                           value:
                                              //                               _teacher,
                                              //                           onChanged:
                                              //                               (newValue) {
                                              //                             setState(
                                              //                                 () {
                                              //                               _teacher =
                                              //                                   newValue.toString();
                                              //                             });
                                              //                           },
                                              //                           items: snapshot
                                              //                               .data!
                                              //                               .docs
                                              //                               .map((location) {
                                              //                             print(
                                              //                                 location['displayName']);
                                              //                             return DropdownMenuItem(
                                              //                               child:
                                              //                                   Padding(
                                              //                                 padding: const EdgeInsets.only(left: 5),
                                              //                                 child: new Text(location['displayName'].toString()),
                                              //                               ),
                                              //                               value:
                                              //                                   location['displayName'].toString(),
                                              //                             );
                                              //                           }).toList(),
                                              //                         ),
                                              //                       );
                                              //                     },
                                              //                   ),
                                              //                 ),
                                              //               ]),
                                              //           SizedBox(
                                              //             height: 20,
                                              //           ),
                                              //           InkWell(
                                              //             onTap: () {
                                              //               setState(() {
                                              //                 isLoading = true;
                                              //               });
                                              //
                                              //               if (addSubject ==
                                              //                       null ||
                                              //                   addSubject!
                                              //                       .isEmpty ||
                                              //                   _teacherValue ==
                                              //                       null ||
                                              //                   _teacherValue!
                                              //                       .isEmpty ||
                                              //                   _classValue ==
                                              //                       null ||
                                              //                   _classValue!
                                              //                       .isEmpty) {
                                              //                 ScaffoldMessenger
                                              //                         .of(context)
                                              //                     .showSnackBar(
                                              //                   Globals
                                              //                       .customSnackBar(
                                              //                     content:
                                              //                         "Please enter all fields properly!",
                                              //                   ),
                                              //                 );
                                              //               } else {
                                              //                 Globals.subjectRef
                                              //                     ?.doc(
                                              //                         addSubject)
                                              //                     .set({
                                              //                   'subject':
                                              //                       addSubject,
                                              //                   "class":
                                              //                       _classValue,
                                              //                   'teacher':
                                              //                       _teacherValue,
                                              //                 }).then((value) {
                                              //                   ScaffoldMessenger.of(
                                              //                           context)
                                              //                       .showSnackBar(
                                              //                     Globals
                                              //                         .customSnackBar(
                                              //                       content:
                                              //                           'Subject $addSubject Added Successfully!',
                                              //                     ),
                                              //                   );
                                              //                 });
                                              //               }
                                              //
                                              //               setState(() {
                                              //                 addSubjectController
                                              //                     ?.clear();
                                              //                 _classValue =
                                              //                     null;
                                              //                 _teacherValue =
                                              //                     null;
                                              //                 isLoading = false;
                                              //               });
                                              //             },
                                              //             child: Container(
                                              //               width: MediaQuery.of(
                                              //                           context)
                                              //                       .size
                                              //                       .width /
                                              //                   2,
                                              //               height: 50,
                                              //               decoration: BoxDecoration(
                                              //                   color: Colors
                                              //                       .indigo,
                                              //                   borderRadius:
                                              //                       BorderRadius
                                              //                           .circular(
                                              //                               20)),
                                              //               child: Center(
                                              //                   child: Text(
                                              //                 'Add',
                                              //                 style: TextStyle(
                                              //                     color: Colors
                                              //                         .white),
                                              //               )),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     btnOkOnPress: () {
                                              //       print('Button Tapped');
                                              //       print(editSubject);
                                              //       Globals.subjectRef
                                              //           ?.doc(snapshot.data!
                                              //                   .docs[index]
                                              //               ['subject'])
                                              //           .delete()
                                              //           .then((value) {
                                              //         Globals.subjectRef
                                              //             ?.doc(editSubject)
                                              //             .set({
                                              //           "subject": editSubject,
                                              //           // "class": _classValue,
                                              //           // 'teacher': 'teachername'
                                              //         }).then((value) {
                                              //           ScaffoldMessenger.of(
                                              //                   context)
                                              //               .showSnackBar(
                                              //             Globals
                                              //                 .customSnackBar(
                                              //               content:
                                              //                   'Subject Edited Successfully!',
                                              //             ),
                                              //           );
                                              //         });
                                              //       });
                                              //
                                              //       // Globals.gradeRef
                                              //       //     ?.doc()
                                              //       //     .update({
                                              //       //   'grade': editSubject
                                              //       // }).then((value) {
                                              //       //   ScaffoldMessenger.of(
                                              //       //           context)
                                              //       //       .showSnackBar(
                                              //       //     Globals.customSnackBar(
                                              //       //       content:
                                              //       //           'grade Edited Successfully!',
                                              //       //     ),
                                              //       //   );
                                              //       // });
                                              //     },
                                              //     btnOkText: 'Save')
                                              //   ..show();

                                              // Navigator.pop(context);

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

                                              Globals.subjectRef
                                                  ?.doc(snapshot.data!
                                                      .docs[index]['subject'])
                                                  .delete()
                                                  .then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  Globals.customSnackBar(
                                                    content:
                                                        'Subject Removed Successfully!',
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
                              //     title: new Text(document.data()?['grade']),
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

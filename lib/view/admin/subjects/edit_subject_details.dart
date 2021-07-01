import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditSubjectDetails extends StatefulWidget {
  var index;
  var editSubject;
  var editClass;
  var editTeacher;

  EditSubjectDetails({
    this.index,
    this.editSubject,
    this.editClass,
    this.editTeacher,
  });

  @override
  _EditSubjectDetailsState createState() => _EditSubjectDetailsState();
}

class _EditSubjectDetailsState extends State<EditSubjectDetails> {
  bool isLoading = false;
  String? editSubject;
  String? _class;
  String? _teacher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editSubject = widget.editSubject;
    _class = widget.editClass;
    _teacher = widget.editTeacher;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit Subject Details'),
            ),
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: 300,
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                child: TextFormField(
                                  // controller: addSubjectController,
                                  showCursor: true,
                                  initialValue: editSubject,
                                  decoration: InputDecoration(
                                    hintText: 'Edit Subject',
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
                                    editSubject = value;
                                    print(editSubject);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    'Class: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
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
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child:
                                                Text('Please Assign a Class'),
                                          ), // Not necessary for Option 1
                                          value: _class,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _class = newValue.toString();
                                            });
                                          },
                                          items: snapshot.data!.docs
                                              .map((location) {
                                            print(location['class']);
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: new Text(
                                                    location['class']
                                                        .toString()),
                                              ),
                                              value:
                                                  location['class'].toString(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    'Teacher: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
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
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child:
                                                Text('Please Assign a Teacher'),
                                          ), // Not necessary for Option 1
                                          value: _teacher,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _teacher = newValue.toString();
                                            });
                                          },
                                          items: snapshot.data!.docs
                                              .map((location) {
                                            print(location['displayName']);
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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

                              print('Button Tapped');
                              print(editSubject);
                              Globals.subjectRef
                                  ?.doc(widget.editSubject)
                                  .delete()
                                  .then((value) {
                                Globals.subjectRef?.doc(editSubject).set({
                                  "subject": editSubject ?? widget.editSubject,
                                  "class": _class ?? widget.editClass,
                                  'teacher': _teacher ?? widget.editTeacher
                                }).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content:
                                          'Subject Details Saved Successfully!',
                                    ),
                                  );
                                });
                              });
                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context);

                              // if (addSubject ==
                              //     null ||
                              //     addSubject!
                              //         .isEmpty ||
                              //     _teacherValue ==
                              //         null ||
                              //     _teacherValue!
                              //         .isEmpty ||
                              //     _classValue ==
                              //         null ||
                              //     _classValue!
                              //         .isEmpty) {
                              //   ScaffoldMessenger
                              //       .of(context)
                              //       .showSnackBar(
                              //     Globals
                              //         .customSnackBar(
                              //       content:
                              //       "Please enter all fields properly!",
                              //     ),
                              //   );
                              // } else {
                              //   Globals.subjectRef
                              //       ?.doc(
                              //       addSubject)
                              //       .set({
                              //     'subject':
                              //     addSubject,
                              //     "class":
                              //     _classValue,
                              //     'teacher':
                              //     _teacherValue,
                              //   }).then((value) {
                              //     ScaffoldMessenger.of(
                              //         context)
                              //         .showSnackBar(
                              //       Globals
                              //           .customSnackBar(
                              //         content:
                              //         'Subject $addSubject Added Successfully!',
                              //       ),
                              //     );
                              //   });
                              // }
                              //
                              // setState(() {
                              //   addSubjectController
                              //       ?.clear();
                              //   _classValue =
                              //   null;
                              //   _teacherValue =
                              //   null;
                              //   isLoading = false;
                              // });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'SAVE',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
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

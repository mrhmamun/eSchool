import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
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
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var newSubject;

  @override
  void initState() {
    addSubjectController = TextEditingController(text: addSubject);
    editSubjectController = TextEditingController(text: editSubject);
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addSubjectController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add a Subject',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    onChanged: (value) {
                                      addSubject = value;
                                      print(addSubject);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    if (addSubject == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        Globals.customSnackBar(
                                          content: "Subject Can't be empty!",
                                        ),
                                      );
                                    } else {
                                      Globals.subjectRef?.doc(addSubject).set({
                                        'subject': addSubject,
                                      }).then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          Globals.customSnackBar(
                                            content:
                                                'Subject $addSubject Added Successfully!',
                                          ),
                                        );
                                      });
                                    }

                                    setState(() {
                                      addSubjectController?.clear();
                                      isLoading = false;
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      'Add',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                                newSubject =
                                    snapshot.data!.docs[index]['subject'];
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
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                                isLoading = true;
                                                editSubject = snapshot.data!
                                                    .docs[index]['subject'];
                                              });

                                              AwesomeDialog(
                                                  context: _scaffoldKey
                                                      .currentContext,
                                                  animType: AnimType.SCALE,
                                                  dialogType: DialogType.INFO,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  body: Container(
                                                    // height: 300,
                                                    // width: 300,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        border: Border.all(
                                                            width: 3,
                                                            color: Colors.white,
                                                            style: BorderStyle
                                                                .solid)),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          child: TextFormField(
                                                            // controller: editSubjectController,
                                                            initialValue:
                                                                editSubject,
                                                            showCursor: true,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Edit Subject',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                            ),
                                                            onChanged: (value) {
                                                              editSubject =
                                                                  value;
                                                              print(
                                                                  editSubject);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  btnOkOnPress: () {
                                                    print('Button Tapped');
                                                    print(editSubject);

                                                    Globals.subjectRef
                                                        ?.doc(snapshot.data!
                                                                .docs[index]
                                                            ['subject'])
                                                        .delete()
                                                        .then((value) {
                                                      Globals.subjectRef
                                                          ?.doc(editSubject)
                                                          .set({
                                                        "subject": editSubject
                                                      }).then((value) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          Globals
                                                              .customSnackBar(
                                                            content:
                                                                'Subject Edited Successfully!',
                                                          ),
                                                        );
                                                      });
                                                    });

                                                    // Globals.gradeRef
                                                    //     ?.doc()
                                                    //     .update({
                                                    //   'grade': editSubject
                                                    // }).then((value) {
                                                    //   ScaffoldMessenger.of(
                                                    //           context)
                                                    //       .showSnackBar(
                                                    //     Globals.customSnackBar(
                                                    //       content:
                                                    //           'grade Edited Successfully!',
                                                    //     ),
                                                    //   );
                                                    // });
                                                  },
                                                  btnOkText: 'Save')
                                                ..show();

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

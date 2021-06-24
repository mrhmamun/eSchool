import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:eschool/view/teacher/test/edit_result_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultDetails extends StatefulWidget {
  var testName;
  var className;
  var subject;
  var dateTime;
  var results;

  ResultDetails(
      {this.subject,
      this.dateTime,
      this.className,
      this.testName,
      this.results});

  @override
  _ResultDetailsState createState() => _ResultDetailsState();
}

class _ResultDetailsState extends State<ResultDetails> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _controller2;
  late TextEditingController resultDetailsNameController;
  late TextEditingController addTestNameController;
  bool isLoading = false;
  String? testName;
  String? _class;
  String? _subejct;
  String? _username;
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  String? editTest;
  String? student;
  String? results;
  String? studentUid;
  String? editResults;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testName = widget.testName;
    _class = widget.className;
    _subejct = widget.subject;
    _valueChanged2 = widget.dateTime;
    Intl.defaultLocale = 'US';
    _controller2 = TextEditingController(text: widget.dateTime.toString());
    addTestNameController = TextEditingController();
    resultDetailsNameController = TextEditingController(text: widget.testName);
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _username = prefs.getString('userName');
      });

      print(_username);
    });
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';

        _controller2.text = widget.dateTime.toString();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller2.dispose();
    resultDetailsNameController.dispose();
    addTestNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Result Details: ' +
                  widget.testName +
                  " || " +
                  widget.subject +
                  " || " +
                  widget.className),
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Test Name: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.testName,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Class: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.className,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Subject: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.subject,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Date & Time: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.dateTime,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
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
                                  'Results: ',
                                  style: TextStyle(color: Colors.black87),
                                )),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                child: TextFormField(
                                  controller: addTestNameController,
                                  showCursor: true,
                                  // initialValue: testName,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        (RegExp("[.0-9]")))
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Results Out of 4.0',
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
                                    results = value;
                                    print(results);
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
                                    'Student: ',
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
                                        .where('userType', isEqualTo: "Student")
                                        .where('class',
                                            isEqualTo: widget.className)
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
                                                Text('Please Select a Student'),
                                          ), // Not necessary for Option 1
                                          value: student,
                                          onChanged: (newValue) {
                                            setState(() {
                                              student = newValue.toString();
                                            });
                                          },
                                          items: snapshot.data!.docs
                                              .map((location) {
                                            studentUid =
                                                location['uid'].toString();
                                            print(studentUid);

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
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              print('Button Tapped');
                              print(testName);
                              if (results == null ||
                                  results!.isEmpty ||
                                  student == null ||
                                  student!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Globals.customSnackBar(
                                    content:
                                        'Please Enter All Fields Properly!',
                                  ),
                                );
                              } else if (results != null && student != null) {
                                Globals.resultRef?.add({
                                  'teacherUid': Globals.auth.currentUser!.uid,
                                  "testName": testName,
                                  "class": _class,
                                  'subject': _subejct,
                                  'timestamp': FieldValue.serverTimestamp(),
                                  'studentUid': studentUid,
                                  'student': student,
                                  'results': results,
                                }).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content: 'Results Added Successfully!',
                                    ),
                                  );

                                  setState(() {
                                    results = null;
                                    student = null;
                                  });
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Globals.customSnackBar(
                                    content: 'Something Went Wrong!',
                                  ),
                                );
                              }

                              setState(() {
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
                          stream: Globals.resultRef!
                              .where('class', isEqualTo: widget.className)
                              .where('subject', isEqualTo: widget.subject)
                              .where('testName', isEqualTo: widget.testName)
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
                                var student =
                                    snapshot.data!.docs[index]['student'];
                                var singleResult =
                                    snapshot.data!.docs[index]['results'];
                                var testName =
                                    snapshot.data!.docs[index]['testName'];
                                // var lastName =
                                //     snapshot.data!.docs[index]['lastName'];
                                // var displayName =
                                //     snapshot.data!.docs[index]['displayName'];
                                // var password =
                                //     snapshot.data!.docs[index]['password'];
                                // var userName =
                                //     snapshot.data!.docs[index]['userName'];
                                // var bio = snapshot.data!.docs[index]['bio'];
                                // var photoUrl =
                                //     snapshot.data!.docs[index]['photoUrl'];
                                // var phoneNumber =
                                //     snapshot.data!.docs[index]['phoneNumber'];
                                // var userType =
                                //     snapshot.data!.docs[index]['userType'];
                                // var publicUrl =
                                //     snapshot.data!.docs[index]['publicUrl'];
                                // var isAdmin =
                                //     snapshot.data!.docs[index]['isAdmin'];
                                // var classValue =
                                //     snapshot.data!.docs[index]['class'];
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                                  student,
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Text(
                                                'CGPA: ' + singleResult,
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
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
                                                          EditResultDetails(
                                                              testName: widget
                                                                  .testName,
                                                              className: widget
                                                                  .className,
                                                              subject: widget
                                                                  .subject,
                                                              dateTime: widget
                                                                  .dateTime,
                                                              results: widget
                                                                  .results,
                                                              singleResult:
                                                                  singleResult,
                                                              student:
                                                                  student)));
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

                                              Globals.resultRef
                                                  ?.where('student',
                                                      isEqualTo: student)
                                                  .get()
                                                  .then((value) {
                                                value.docs.single.reference
                                                    .delete();
                                              }).then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  Globals.customSnackBar(
                                                    content:
                                                        'Results Removed Successfully!',
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

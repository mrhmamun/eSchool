import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eschool/global/globals.dart';
import 'package:eschool/view/teacher/test/edit_test_details.dart';
import 'package:eschool/view/teacher/test/result_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTest extends StatefulWidget {
  @override
  _AddTestState createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _controller2;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Intl.defaultLocale = 'US';
    _controller2 = TextEditingController(text: DateTime.now().toString());
    addTestNameController = TextEditingController();
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

        _controller2.text = '2001-10-21 15:31';
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller2.dispose();
    addTestNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
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
                                  'Test Name: ',
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
                                  decoration: InputDecoration(
                                    hintText: 'Test Name',
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
                                    testName = value;
                                    print(testName);
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
                                                Text('Please Select a Class'),
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
                                    'Subject: ',
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
                                    stream: Globals.subjectRef
                                        ?.where('teacher', isEqualTo: _username)
                                        .where('class', isEqualTo: _class)
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
                                                Text('Please Select a Subject'),
                                          ), // Not necessary for Option 1
                                          value: _subejct,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _subejct = newValue.toString();
                                            });
                                          },
                                          items: snapshot.data!.docs
                                              .map((location) {
                                            print(location['subject']);
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: new Text(
                                                    location['subject']
                                                        .toString()),
                                              ),
                                              value: location['subject']
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
                                  'Date & Time: ',
                                  style: TextStyle(color: Colors.black87),
                                )),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                                child: DateTimePicker(
                                  type: DateTimePickerType.dateTime,
                                  dateMask: 'd MMMM, yyyy - hh:mm a',
                                  controller: _controller2,
                                  //initialValue: _initialValue,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  decoration: InputDecoration(
                                    hintText: 'Test Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  //icon: Icon(Icons.event),
                                  // dateLabelText: 'Date Time',
                                  use24HourFormat: false,
                                  locale: Locale('en', 'US'),
                                  onChanged: (val) =>
                                      setState(() => _valueChanged2 = val),
                                  validator: (val) {
                                    setState(
                                        () => _valueToValidate2 = val ?? '');
                                    return null;
                                  },
                                  onSaved: (val) =>
                                      setState(() => _valueSaved2 = val ?? ''),
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

                              print('Button Tapped');
                              print(testName);
                              if (testName == null ||
                                  testName!.isEmpty ||
                                  _class == null ||
                                  _class!.isEmpty ||
                                  _subejct == null ||
                                  _subejct!.isEmpty ||
                                  _valueChanged2 == null ||
                                  testName!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Globals.customSnackBar(
                                    content:
                                        'Please Enter All Fields Properly!',
                                  ),
                                );
                              } else if (testName != null &&
                                  _class != null &&
                                  _subejct != null &&
                                  _valueChanged2 != null) {
                                Globals.testRef?.doc(testName).set({
                                  'teacherUid': Globals.auth.currentUser!.uid,
                                  "testName": testName,
                                  "class": _class,
                                  'subject': _subejct,
                                  'dateTime':
                                      _controller2.text ?? _valueChanged2,
                                  'results': [],
                                }).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content: 'Test Added Successfully!',
                                    ),
                                  );

                                  setState(() {
                                    addTestNameController.clear();
                                    _class = null;
                                    _subejct = null;
                                    _valueChanged2 = '';
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
                          stream: Globals.testRef
                              ?.where('teacherUid',
                                  isEqualTo: Globals.auth.currentUser!.uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            print(snapshot.data?.docs.length);
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Something went wrong'));
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
                                var _testName =
                                    snapshot.data!.docs[index]['testName'];

                                var dateTime =
                                    snapshot.data!.docs[index]['dateTime'];
                                var className =
                                    snapshot.data!.docs[index]['class'];
                                var subject =
                                    snapshot.data!.docs[index]['subject'];
                                var results =
                                    snapshot.data!.docs[index]['results'];
                                print("results");
                                print(results);
                                var newIndex = index + 1;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultDetails(
                                                testName: _testName,
                                                className: className,
                                                subject: subject,
                                                dateTime: dateTime,
                                                results: results)));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                _testName +
                                                    " || " +
                                                    subject +
                                                    " || " +
                                                    className,
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
                                                            EditTestDetails(
                                                                testName:
                                                                    _testName,
                                                                className:
                                                                    className,
                                                                subject:
                                                                    subject,
                                                                dateTime:
                                                                    dateTime,
                                                                results:
                                                                    results)));
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

                                                Globals.testRef
                                                    ?.doc(snapshot
                                                            .data!.docs[index]
                                                        ['testName'])
                                                    .delete()
                                                    .then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    Globals.customSnackBar(
                                                      content:
                                                          'Test Removed Successfully!',
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
                                  ),
                                );
                              },

                              // children: snapshot.data!.docs
                              //     .map((DocumentSnapshot document) {
                              //   return new ListTile(
                              //     title: new Text(document.data()?['Class']),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTestDetails extends StatefulWidget {
  var testName;
  var className;
  var subject;
  var dateTime;
  var results;

  EditTestDetails(
      {this.subject,
      this.dateTime,
      this.className,
      this.testName,
      this.results});

  @override
  _EditTestDetailsState createState() => _EditTestDetailsState();
}

class _EditTestDetailsState extends State<EditTestDetails> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _controller2;
  late TextEditingController editTestDetailsNameController;
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
    testName = widget.testName;
    _class = widget.className;
    _subejct = widget.subject;
    _valueChanged2 = widget.dateTime;
    Intl.defaultLocale = 'US';
    _controller2 = TextEditingController(text: widget.dateTime.toString());
    editTestDetailsNameController =
        TextEditingController(text: widget.testName);
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
    editTestDetailsNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit Test Details || Teacher View'),
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
                                  'Test Name: ',
                                  style: TextStyle(color: Colors.black87),
                                )),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                child: TextFormField(
                                  controller: editTestDetailsNameController,
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
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              if (_subejct == null || _subejct!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Globals.customSnackBar(
                                    content:
                                        'Please enter all fields properly!',
                                  ),
                                );
                              } else {
                                Globals.testRef
                                    ?.doc(widget.testName)
                                    .delete()
                                    .then((value) {
                                  Globals.testRef?.doc(testName).set({
                                    'teacherUid': Globals.auth.currentUser!.uid,
                                    "testName": testName ?? widget.testName,
                                    "class": _class ?? widget.className,
                                    'subject': _subejct ?? widget.subject,
                                    'dateTime':
                                        _valueChanged2 ?? widget.dateTime,
                                    'results': widget.results,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      Globals.customSnackBar(
                                        content:
                                            'Test Details Edited Successfully!',
                                      ),
                                    );
                                    Navigator.pop(context);
                                  });
                                });
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
                                'Save',
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditResultDetails extends StatefulWidget {
  var testName;
  var className;
  var subject;
  var dateTime;
  var results;
  var student;
  var singleResult;

  EditResultDetails(
      {this.subject,
      this.dateTime,
      this.className,
      this.testName,
      this.student,
      this.singleResult,
      this.results});

  @override
  _EditResultDetailsState createState() => _EditResultDetailsState();
}

class _EditResultDetailsState extends State<EditResultDetails> {
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
  String? student;
  String? results;
  String? studentUid;
  String? editResults;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.results");
    print(widget.results);
    testName = widget.testName;
    _class = widget.className;
    _subejct = widget.subject;
    _valueChanged2 = widget.dateTime;
    Intl.defaultLocale = 'US';
    _controller2 = TextEditingController(text: widget.dateTime.toString());
    addTestNameController = TextEditingController(text: widget.singleResult);

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
    addTestNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Edit Result Details: ' +
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Student: ',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.student,
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
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
                                    setState(() {
                                      results = value;
                                    });
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
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              Globals.resultRef
                                  ?.where('student', isEqualTo: widget.student)
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  print(element['results']);

                                  element.reference.update(
                                      {'results': results ?? widget.results});
                                });
                              }).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Globals.customSnackBar(
                                    content: 'Results Updated Successfully!',
                                  ),
                                );
                              });

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Update',
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

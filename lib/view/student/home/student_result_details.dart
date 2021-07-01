import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentResultDetails extends StatefulWidget {
  var testName;
  var className;
  var subject;
  var dateTime;
  var results;

  StudentResultDetails(
      {this.subject,
      this.dateTime,
      this.className,
      this.testName,
      this.results});

  @override
  _StudentResultDetailsState createState() => _StudentResultDetailsState();
}

class _StudentResultDetailsState extends State<StudentResultDetails> {
  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _controller2;
  late TextEditingController StudentResultDetailsNameController;
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
    StudentResultDetailsNameController =
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
    StudentResultDetailsNameController.dispose();
    addTestNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final pdf = pw.Document();
    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (context) {
    //       return pw.Center(child: pw.Text('This is pdf'));
    //     }));

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
                child: GestureDetector(
                  onTap: () async {
                    // final bytes = await pdf.save();
                    // final blob = html.Blob([bytes], 'application/pdf');
                    // final url = html.Url.createObjectUrlFromBlob(blob);
                    // html.window.open(url, '_blank');
                    // html.Url.revokeObjectUrl(url);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
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
                                  'CGPA: ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  // padding: EdgeInsets.only(top: 10),
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: Globals.resultRef!
                                        .where('class',
                                            isEqualTo: widget.className)
                                        .where('subject',
                                            isEqualTo: widget.subject)
                                        .where('testName',
                                            isEqualTo: widget.testName)
                                        .where('studentUid',
                                            isEqualTo:
                                                Globals.auth.currentUser!.uid)
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var item = snapshot.data!.docs[index];
                                          var newIndex = index + 1;
                                          var student = snapshot
                                              .data!.docs[index]['student'];
                                          var singleResult = snapshot
                                              .data!.docs[index]['results'];
                                          var testName = snapshot
                                              .data!.docs[index]['testName'];

                                          return Text(
                                            singleResult,
                                            style: TextStyle(
                                                color: Colors.black87),
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
                    ],
                  ),
                ),
              ),
            ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endDocked,
            // floatingActionButton: Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: FloatingActionButton(
            //     onPressed: () async {
            //       final bytes = await pdf.save();
            //       final blob = html.Blob([bytes], 'application/pdf');
            //       final url = html.Url.createObjectUrlFromBlob(blob);
            //       final anchor = html.AnchorElement()
            //         ..href = url
            //         ..style.display = 'none'
            //         ..download = 'some_name.pdf';
            //       html.document.body?.children.add(anchor);
            //       anchor.click();
            //       html.document.body?.children.remove(anchor);
            //       html.Url.revokeObjectUrl(url);
            //     },
            //     child: Icon(Icons.download_sharp),
            //   ),
            // ),
          ),
        ));
  }
}

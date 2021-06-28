import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentSubjectsList extends StatefulWidget {
  @override
  _StudentSubjectsListState createState() => _StudentSubjectsListState();
}

class _StudentSubjectsListState extends State<StudentSubjectsList> {
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

  var className;

  @override
  void initState() {
    addSubjectController = TextEditingController(text: addSubject);
    editSubjectController = TextEditingController();
    // editSubjectController = TextEditingController(text: editSubject);

    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          className = prefs.getString('class');
        });
      }
    });
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Globals.subjectRef
                              ?.where('class', isEqualTo: className.toString())
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
                                                100,
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
                                                      ['class'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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

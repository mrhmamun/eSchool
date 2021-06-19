import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddTestQuestion extends StatefulWidget {
  @override
  _AddTestQuestionState createState() => _AddTestQuestionState();
}

class _AddTestQuestionState extends State<AddTestQuestion> {
  TextEditingController? addOptionController1;
  TextEditingController? addOptionController2;
  TextEditingController? addOptionController3;
  TextEditingController? addOptionController4;
  TextEditingController? addQuestionTitleController;
  TextEditingController? addQuestionDescController;
  String? _addQuestion;
  String? _question;
  String? _desc;
  String? _option1;
  String? _option2;
  String? _option3;
  String? _option4;
  String? _categoryValue; // Option 2
  String? _gradeValue; // Option 2
  String? _subjectValue;
  String? answerOfTheQuestion;
  String? _videoTitle;
  String? _videoUrl;
  int? answerIndex;
  List<String> answerOfTheQuestionList = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
  ]; // Option 2

  bool isLoading = false;

  @override
  void initState() {
    addOptionController1 = TextEditingController();
    addOptionController2 = TextEditingController();
    addOptionController3 = TextEditingController();
    addOptionController4 = TextEditingController();
    addQuestionTitleController = TextEditingController();
    addQuestionDescController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addOptionController1?.dispose();
    addOptionController2?.dispose();
    addOptionController3?.dispose();
    addOptionController4?.dispose();
    addQuestionTitleController?.dispose();
    addQuestionDescController?.dispose();
    // TODO: implement dispose
    super.dispose();
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
                                    'Question: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addQuestionTitleController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Question',
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
                                      _question = value;
                                      print(_question);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       width: MediaQuery.of(context).size.width / 10,
                            //       height: 50,
                            //       decoration: BoxDecoration(
                            //         color: Colors.grey.shade300,
                            //         borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(20),
                            //           bottomLeft: Radius.circular(20),
                            //         ),
                            //       ),
                            //       child: Center(
                            //           child: Text(
                            //         'Description: ',
                            //         style: TextStyle(color: Colors.black87),
                            //       )),
                            //     ),
                            //     Container(
                            //       width: MediaQuery.of(context).size.width / 2 -
                            //           200,
                            //       height: 50,
                            //       child: TextField(
                            //         controller: addQuestionDescController,
                            //         showCursor: true,
                            //         maxLines: 10,
                            //         decoration: InputDecoration(
                            //           hintText:
                            //               'Add Question Short Description',
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.only(
                            //               topRight: Radius.circular(20),
                            //               bottomRight: Radius.circular(20),
                            //             ),
                            //           ),
                            //           // suffix: FloatingActionButton(
                            //           //   child: Icon(Icons.add_circle),
                            //           //   onPressed: () {},
                            //           // ),
                            //           // suffixIcon: Icon(Icons.add_circle),
                            //         ),
                            //         onChanged: (value) {
                            //           _desc = value;
                            //           print(_desc);
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                                      'Category: ',
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
                                        print(snapshot.data?.docs.length);
                                        if (snapshot.hasError) {
                                          return Text('Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text("Loading");
                                        }
                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                  'Please choose a Category'),
                                            ), // Not necessary for Option 1
                                            value: _categoryValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _categoryValue =
                                                    newValue.toString();
                                              });
                                            },
                                            items: snapshot.data!.docs
                                                .map((location) {
                                              return DropdownMenuItem(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: new Text(
                                                      location['category']
                                                          .toString()),
                                                ),
                                                value: location['category']
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
                                      'Grade: ',
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
                                      stream:
                                          Globals.subCategoryRef?.snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        print(snapshot.data?.docs.length);
                                        if (snapshot.hasError) {
                                          return Text('Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text("Loading");
                                        }
                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child:
                                                  Text('Please choose a Grade'),
                                            ), // Not necessary for Option 1
                                            value: _gradeValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _gradeValue =
                                                    newValue.toString();
                                              });
                                            },
                                            items: snapshot.data!.docs
                                                .map((location) {
                                              return DropdownMenuItem(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: new Text(
                                                      location['grade']
                                                          .toString()),
                                                ),
                                                value: location['grade']
                                                    .toString(),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         width:
                            //             MediaQuery.of(context).size.width / 10,
                            //         height: 50,
                            //         decoration: BoxDecoration(
                            //           color: Colors.grey.shade300,
                            //           borderRadius: BorderRadius.only(
                            //             topLeft: Radius.circular(20),
                            //             bottomLeft: Radius.circular(20),
                            //           ),
                            //         ),
                            //         child: Center(
                            //             child: Text(
                            //           'Subject: ',
                            //           style: TextStyle(color: Colors.black87),
                            //         )),
                            //       ),
                            //       Container(
                            //         width:
                            //             MediaQuery.of(context).size.width / 2 -
                            //                 200,
                            //         height: 50,
                            //         decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 color: Colors.grey, width: 1),
                            //             borderRadius: BorderRadius.only(
                            //               topRight: Radius.circular(20),
                            //               bottomRight: Radius.circular(20),
                            //             )),
                            //         child: StreamBuilder(
                            //           stream: Globals.subjectRef?.snapshots(),
                            //           builder: (BuildContext context,
                            //               AsyncSnapshot<QuerySnapshot>
                            //                   snapshot) {
                            //             print(snapshot.data?.docs.length);
                            //             if (snapshot.hasError) {
                            //               return Text('Something went wrong');
                            //             }
                            //             if (snapshot.connectionState ==
                            //                 ConnectionState.waiting) {
                            //               return Text("Loading");
                            //             }
                            //             return DropdownButtonHideUnderline(
                            //               child: DropdownButton(
                            //                 hint: Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       left: 5),
                            //                   child: Text(
                            //                       'Please choose a Subject'),
                            //                 ), // Not necessary for Option 1
                            //                 value: _subjectValue,
                            //                 onChanged: (newValue) {
                            //                   setState(() {
                            //                     _subjectValue =
                            //                         newValue.toString();
                            //                   });
                            //                 },
                            //                 items: snapshot.data!.docs
                            //                     .map((location) {
                            //                   return DropdownMenuItem(
                            //                     child: Padding(
                            //                       padding:
                            //                           const EdgeInsets.only(
                            //                               left: 5),
                            //                       child: new Text(
                            //                           location['subject']
                            //                               .toString()),
                            //                     ),
                            //                     value: location['subject']
                            //                         .toString(),
                            //                   );
                            //                 }).toList(),
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ]),
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
                                      'Video: ',
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
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: Globals.videoRef!
                                          // .doc(_categoryValue)
                                          // .collection(_gradeValue.toString())
                                          .where('category',
                                              isEqualTo:
                                                  _categoryValue.toString())
                                          .where('grade',
                                              isEqualTo: _gradeValue.toString())
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                              child:
                                                  Text('Something went wrong'));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(child: Text("Loading"));
                                        }
                                        print("Actual length");
                                        print(snapshot.data!.docs.length);

                                        for (int i = 0;
                                            i < snapshot.data!.docs.length;
                                            i++) {
                                          var item = snapshot.data!.docs[i];
                                          print("Actual length aaaaaaaaaa");
                                          // imageUrl = item['imageUrl'];
                                          // print(imageUrl);
                                        }

                                        return Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            height: 50,
                                            // width: 300,
                                            child: DropdownButtonHideUnderline(
                                              child: new DropdownButton<String>(
                                                hint: Text('Select Video'),
                                                value: _videoTitle,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _videoTitle =
                                                        value.toString();
                                                  });
                                                  print(value);
                                                },
                                                items: snapshot.data!.docs
                                                    .map((value) {
                                                  _videoUrl =
                                                      value['url'].toString();
                                                  print(_videoUrl);
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value['title']
                                                        .toString(),
                                                    child: new Text(
                                                      value['title'].toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
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
                                    'Option 1: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addOptionController1,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Option 1',
                                      // errorText: validateText(
                                      //     addQuestionController?.text, 'URL'),
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
                                      _option1 = value;
                                      print(_option1);
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
                                    'Option 2: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addOptionController2,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Option 2',
                                      // errorText: validateText(
                                      //     addQuestionController?.text, 'URL'),
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
                                      _option2 = value;
                                      print(_option2);
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
                                    'Option 3: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addOptionController3,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Option 3',
                                      // errorText: validateText(
                                      //     addQuestionController?.text, 'URL'),
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
                                      _option3 = value;
                                      print(_option3);
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
                                    'Option 4: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addOptionController4,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Option 4',
                                      // errorText: validateText(
                                      //     addQuestionController?.text, 'URL'),
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
                                      _option4 = value;
                                      print(_option4);
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
                                      'Answer: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  Container(
                                    height: 50,
                                    // width: 300,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            200,

                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    child: DropdownButtonHideUnderline(
                                      child: new DropdownButton<String>(
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text('Select Answer'),
                                        ),
                                        value: answerOfTheQuestion,
                                        onChanged: (value) {
                                          setState(() {
                                            answerOfTheQuestion =
                                                value.toString();
                                          });

                                          if (answerOfTheQuestion ==
                                              "Option 1") {
                                            setState(() {
                                              answerIndex = 1;
                                            });
                                          } else if (answerOfTheQuestion ==
                                              "Option 2") {
                                            setState(() {
                                              answerIndex = 2;
                                            });
                                          } else if (answerOfTheQuestion ==
                                              "Option 3") {
                                            setState(() {
                                              answerIndex = 3;
                                            });
                                          } else if (answerOfTheQuestion ==
                                              "Option 4") {
                                            setState(() {
                                              answerIndex = 4;
                                            });
                                          }

                                          print(value);
                                          print(answerIndex);
                                        },
                                        items: answerOfTheQuestionList
                                            .map((value) {
                                          return new DropdownMenuItem<String>(
                                            value: value.toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
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
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });

                                if (_question == null ||
                                    _question!.isEmpty ||
                                    _categoryValue == null ||
                                    _categoryValue!.isEmpty ||
                                    _gradeValue == null ||
                                    _gradeValue!.isEmpty ||
                                    _option1 == null ||
                                    _option1!.isEmpty ||
                                    _option2!.isEmpty ||
                                    _option3!.isEmpty ||
                                    _option4!.isEmpty ||
                                    answerOfTheQuestion!.isEmpty) {
                                  print('Empty Error');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content:
                                          'Please enter all fields properly!',
                                    ),
                                  );
                                } else {
                                  Globals.QuestionRef?.doc(
                                          _categoryValue.toString())
                                      .collection(_gradeValue.toString())
                                      .add({
                                    'category': _categoryValue,
                                    'grade': _gradeValue,
                                    // 'subject': _subjectValue,
                                    'question': _question,
                                    // 'desc': _desc,
                                    'option1': _option1,
                                    'option2': _option2,
                                    'option3': _option3,
                                    'option4': _option4,
                                    'answer': answerOfTheQuestion,
                                    'answerIndex': answerIndex,
                                    'videoUrl': _videoUrl,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      Globals.customSnackBar(
                                        content: 'Question Added Successfully!',
                                      ),
                                    );

                                    setState(() {
                                      addQuestionTitleController?.clear();
                                      // addQuestionDescController?.clear();
                                      addOptionController1?.clear();
                                      addOptionController2?.clear();
                                      addOptionController3?.clear();
                                      addOptionController4?.clear();
                                      _categoryValue = null;
                                      _gradeValue = null;
                                      _subjectValue = null;
                                      answerIndex = null;
                                      answerOfTheQuestion = null;
                                      _videoUrl = null;
                                    });
                                  });
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  validateText(String? value, String? field) {
    if (value == null || value.isEmpty) {
      return "$field Field Can't be empty";
    }
    return null;
  }
}

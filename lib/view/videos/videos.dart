import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  TextEditingController? addVideoController;
  TextEditingController? addVideoTitleController;
  TextEditingController? addVideoDescController;
  TextEditingController? addChordsAndLyricsController;
  String? _addVideo;
  String? _title;
  String? _desc;
  String? _chordsAndLyrics;
  String? _url;
  String? _categoryValue; // Option 2
  String? _gradeValue; // Option 2
  String? _subjectValue; // Option 2
  String? _thumbImage; //
  String? _videoFor; //
  String? _videoVersion; //
  int? answerIndex;
  int? videoVersionAnswerIndex;
  List<String> _videoForList = [
    'Instrumental',
    'Vocal Version',
  ]; //
  List<String> _videoVersionList = [
    'Free',
    'Paid',
  ]; //

  bool isLoading = false;

  @override
  void initState() {
    addVideoController = TextEditingController(text: _addVideo);
    addVideoTitleController = TextEditingController();
    addVideoDescController = TextEditingController();
    addChordsAndLyricsController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addVideoController?.dispose();
    addVideoTitleController?.dispose();
    addVideoDescController?.dispose();
    addChordsAndLyricsController?.dispose();
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
                                    'Title: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addVideoTitleController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add Video Title',
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
                                      _title = value;
                                      print(_title);
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
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Description: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 150,
                                  child: TextField(
                                    controller: addVideoDescController,
                                    showCursor: true,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: 'Add Video Description',
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
                                      _desc = value;
                                      print(_desc);
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
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Chords & Lyrics : ',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 200,
                                  child: TextField(
                                    controller: addChordsAndLyricsController,
                                    showCursor: true,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: 'Add Chords And Lyrics',
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
                                      _chordsAndLyrics = value;
                                      print(_chordsAndLyrics);
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
                                      stream: Globals.categoryRef?.snapshots(),
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
                            //           'Grade: ',
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
                            //           stream:
                            //               Globals.subCategoryRef?.snapshots(),
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
                            //                   child:
                            //                       Text('Please choose a Grade'),
                            //                 ), // Not necessary for Option 1
                            //                 value: _gradeValue,
                            //                 onChanged: (newValue) {
                            //                   setState(() {
                            //                     _gradeValue =
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
                            //                           location['grade']
                            //                               .toString()),
                            //                     ),
                            //                     value: location['grade']
                            //                         .toString(),
                            //                   );
                            //                 }).toList(),
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ]),
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
                            // SizedBox(
                            //   height: 20,
                            // ),
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
                                      'Type',
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
                                          child: Text('Select Video Type'),
                                        ),
                                        value: _videoFor,
                                        onChanged: (value) {
                                          setState(() {
                                            _videoFor = value.toString();
                                          });

                                          if (_videoFor == "Instrumental") {
                                            setState(() {
                                              answerIndex = 1;
                                            });
                                          } else if (_videoFor ==
                                              "Vocal Version") {
                                            setState(() {
                                              answerIndex = 2;
                                            });
                                          }
                                        },
                                        items: _videoForList.map((value) {
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
                                      'Version',
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
                                          child: Text('Select Video Version'),
                                        ),
                                        value: _videoVersion,
                                        onChanged: (value) {
                                          setState(() {
                                            _videoVersion = value.toString();
                                          });

                                          if (_videoVersion == "Free") {
                                            setState(() {
                                              videoVersionAnswerIndex = 1;
                                            });
                                          } else if (_videoVersion == "Paid") {
                                            setState(() {
                                              videoVersionAnswerIndex = 2;
                                            });
                                          }
                                          // else if (_videoFor == "Advance") {
                                          //   setState(() {
                                          //     answerIndex = 3;
                                          //   }
                                          //
                                          //   );
                                          // }
                                          //
                                          //
                                          // print(value);
                                          // print(answerIndex);
                                        },
                                        items: _videoVersionList.map((value) {
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
                                      'Thumbnail: ',
                                      style: TextStyle(color: Colors.black87),
                                    )),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await imagePicker();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Add a Thumbnail',
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            _thumbImage == null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
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
                                            'Preview: ',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          )),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              )),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ])
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
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
                                            'Image: ',
                                            style: TextStyle(
                                                color: Colors.black87),
                                          )),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              )),
                                          child: Image.network(
                                            _thumbImage.toString(),
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                200,
                                            height: 200,
                                            fit: BoxFit.cover,
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
                                    'URL: ',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      200,
                                  height: 50,
                                  child: TextField(
                                    controller: addVideoController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add a Yt Video Url',
                                      // errorText: validateText(
                                      //     addVideoController?.text, 'URL'),
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
                                      _url = value;
                                      print(_url);
                                    },
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

                                if (_title == null ||
                                    _title!.isEmpty ||
                                    _desc == null ||
                                    _desc!.isEmpty ||
                                    _categoryValue == null ||
                                    _categoryValue!.isEmpty ||
                                    // _gradeValue == null ||
                                    // _gradeValue!.isEmpty ||
                                    // _subjectValue == null ||
                                    // _subjectValue!.isEmpty ||
                                    _url == null ||
                                    _url!.isEmpty ||
                                    _thumbImage == null ||
                                    _thumbImage!.isEmpty ||
                                    _videoFor == null ||
                                    _videoFor!.isEmpty ||
                                    _videoVersion!.isEmpty ||
                                    _videoVersion == null) {
                                  print('Empty Error');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Globals.customSnackBar(
                                      content:
                                          'Please enter all fields properly!',
                                    ),
                                  );
                                } else {
                                  Globals.videoRef!.add({
                                    'category': _categoryValue,
                                    // 'grade': _gradeValue,
                                    // 'subject': _subjectValue,
                                    'title': _title,
                                    'desc': _desc,
                                    'chordsAndLyrics': _chordsAndLyrics,
                                    'url': _url,
                                    'imageUrl': _thumbImage,
                                    'videoFor': _videoFor,
                                    'videoVersion': _videoVersion,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      Globals.customSnackBar(
                                        content: 'Video Added Successfully!',
                                      ),
                                    );

                                    setState(() {
                                      addVideoTitleController?.clear();
                                      addVideoDescController?.clear();
                                      addVideoController?.clear();
                                      addChordsAndLyricsController?.clear();
                                      _categoryValue = null;
                                      // _gradeValue = null;
                                      // _subjectValue = null;
                                      _chordsAndLyrics = null;
                                      _thumbImage = null;
                                      _videoFor = null;
                                      _videoVersion = null;
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
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => AllVideos()));
                            //   },
                            //   child: Container(
                            //     width: MediaQuery.of(context).size.width,
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //         color: Colors.indigo,
                            //         borderRadius: BorderRadius.circular(20)),
                            //     child: Center(
                            //         child: Text(
                            //       'All Videos',
                            //       style: TextStyle(color: Colors.white),
                            //     )),
                            //   ),
                            // ),
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

  // late String imgUrl;
  //
  // imagePicker() {
  //   var input = FileUploadInputElement()..accept = 'image/*';
  //   FirebaseStorage fs = FirebaseStorage.instance;
  //   input.click();
  //   input.onChange.listen((event) {
  //     final file = input.files!.first;
  //     final reader = FileReader();
  //     reader.readAsDataUrl(file);
  //     reader.onLoadEnd.listen((event) async {
  //       var snapshot = await fs.ref().child('newfile').putBlob(file);
  //       String downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imgUrl = downloadUrl;
  //         print(imgUrl);
  //       });
  //     });
  //   });
  // }

  imagePicker() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      Uint8List uploadFile = result.files.single.bytes!;

      String? fileName = result.files.single.name;
      var uuid = Uuid();

      Reference reference =
          FirebaseStorage.instance.ref('images').child(uuid.v4());

      print(reference);
      print(uuid.v4());

      final UploadTask uploadTask = reference.putData(uploadFile);
      // final UploadTask uploadTask = reference.putData(uploadFile);

      // if (uploadTask.snapshot.state == TaskState.success) {
      //   String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      //   print(downloadUrl);
      //   print('file uploaded');
      // } else {
      //   print("error");
      //

      uploadTask.whenComplete(() async {
        String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
        print(downloadUrl);
        print('file uploaded');
        setState(() {
          _thumbImage = downloadUrl;
        });
      }).catchError((e) {
        print(e);
      });

      print(fileName);
    } else {
      // User canceled the picker
    }
  }

  validateText(String? value, String? field) {
    if (value == null || value.isEmpty) {
      return "$field Field Can't be empty";
    }
    return null;
  }
}

// NewImageUpload

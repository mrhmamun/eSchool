import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AllVideos extends StatefulWidget {
  @override
  _AllVideosState createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
  TextEditingController? addCategoryController;
  TextEditingController? editCategoryController;
  String? addCategory;
  String? editCategory;
  String? _categoryValue;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var newCat;

  @override
  void initState() {
    addCategoryController = TextEditingController(text: addCategory);
    editCategoryController = TextEditingController(text: editCategory);
    // editCategoryController = TextEditingController(text: editCategory);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    addCategoryController?.dispose();
    editCategoryController?.dispose();
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
                        child: Row(
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
                                  'Category: ',
                                  style: TextStyle(color: Colors.black87),
                                )),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 200,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                                child: StreamBuilder(
                                  stream: Globals.categoryRef?.snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    print(snapshot.data?.docs.length);
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text('Something went wrong'));
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
                                              Text('Please choose a Category'),
                                        ), // Not necessary for Option 1
                                        value: _categoryValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _categoryValue =
                                                newValue.toString();
                                          });
                                        },
                                        items:
                                            snapshot.data!.docs.map((location) {
                                          return DropdownMenuItem(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: new Text(
                                                  location['category']
                                                      .toString()),
                                            ),
                                            value:
                                                location['category'].toString(),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ]),
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
                          stream: Globals.videoRef
                              ?.where('category', isEqualTo: _categoryValue)
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
                              return Center(child: Text("Loading"));
                            }

                            return new ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(snapshot.data!.docs[index]['title']);
                                var item = snapshot.data!.docs[index];
                                print(item);
                                newCat = snapshot.data!.docs[index]['title'];
                                print(newCat);

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
                                                120,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
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
                                              newCat,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          // InkWell(
                                          //   onTap: () async {
                                          //     setState(() {
                                          //       isLoading = true;
                                          //       editCategory = snapshot.data!
                                          //           .docs[index]['category'];
                                          //     });
                                          //
                                          //     AwesomeDialog(
                                          //         context: _scaffoldKey
                                          //             .currentContext,
                                          //         animType: AnimType.SCALE,
                                          //         dialogType: DialogType.INFO,
                                          //         width: MediaQuery.of(context)
                                          //                 .size
                                          //                 .width /
                                          //             3,
                                          //         body: Container(
                                          //           // height: 300,
                                          //           // width: 300,
                                          //           padding: EdgeInsets.all(5),
                                          //           decoration: BoxDecoration(
                                          //               color: Colors.white,
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           15)),
                                          //               border: Border.all(
                                          //                   width: 3,
                                          //                   color: Colors.white,
                                          //                   style: BorderStyle
                                          //                       .solid)),
                                          //           child: Column(
                                          //             children: [
                                          //               SizedBox(
                                          //                 height: 10,
                                          //               ),
                                          //               Container(
                                          //                 height: 50,
                                          //                 child: TextFormField(
                                          //                   // controller: editCategoryController,
                                          //                   initialValue:
                                          //                       editCategory,
                                          //                   showCursor: true,
                                          //                   decoration:
                                          //                       InputDecoration(
                                          //                     hintText:
                                          //                         'Edit Category',
                                          //                     border: OutlineInputBorder(
                                          //                         borderRadius:
                                          //                             BorderRadius
                                          //                                 .circular(
                                          //                                     20)),
                                          //                   ),
                                          //                   onChanged: (value) {
                                          //                     editCategory =
                                          //                         value;
                                          //                     print(
                                          //                         editCategory);
                                          //                   },
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         btnOkOnPress: () {
                                          //           print('Button Tapped');
                                          //           print(editCategory);
                                          //
                                          //           Globals.categoryRef
                                          //               ?.doc(snapshot.data!
                                          //                       .docs[index]
                                          //                   ['category'])
                                          //               .delete()
                                          //               .then((value) {
                                          //             Globals.categoryRef
                                          //                 ?.doc(editCategory)
                                          //                 .set({
                                          //               "category": editCategory
                                          //             }).then((value) {
                                          //               ScaffoldMessenger.of(
                                          //                       context)
                                          //                   .showSnackBar(
                                          //                 Globals
                                          //                     .customSnackBar(
                                          //                   content:
                                          //                       'Category Edited Successfully!',
                                          //                 ),
                                          //               );
                                          //             });
                                          //           });
                                          //
                                          //           // Globals.categoryRef
                                          //           //     ?.doc()
                                          //           //     .update({
                                          //           //   'category': editCategory
                                          //           // }).then((value) {
                                          //           //   ScaffoldMessenger.of(
                                          //           //           context)
                                          //           //       .showSnackBar(
                                          //           //     Globals.customSnackBar(
                                          //           //       content:
                                          //           //           'Category Edited Successfully!',
                                          //           //     ),
                                          //           //   );
                                          //           // });
                                          //         },
                                          //         btnOkText: 'Save')
                                          //       ..show();
                                          //
                                          //     // Navigator.pop(context);
                                          //
                                          //     setState(() {
                                          //       isLoading = false;
                                          //     });
                                          //   },
                                          //   child: Container(
                                          //     // width: 100,
                                          //     height: 50,
                                          //     padding: EdgeInsets.all(10),
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.indigo,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 20)),
                                          //
                                          //     child: Center(
                                          //         child: Icon(
                                          //       Icons.edit,
                                          //       color: Colors.white,
                                          //     )),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              Globals.videoRef
                                                  ?.get()
                                                  .then((value) {
                                                if (item.exists) {
                                                  item.reference.delete();
                                                }

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  Globals.customSnackBar(
                                                    content:
                                                        'Video Removed Successfully!',
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

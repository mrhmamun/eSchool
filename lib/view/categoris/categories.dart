import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController? addCategoryController;
  TextEditingController? editCategoryController;
  String? addCategory;
  String? editCategory;
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
                                    controller: addCategoryController,
                                    showCursor: true,
                                    decoration: InputDecoration(
                                      hintText: 'Add a Category',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    onChanged: (value) {
                                      addCategory = value;
                                      print(addCategory);
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

                                    if (addCategory == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        Globals.customSnackBar(
                                          content: "Category Can't be empty!",
                                        ),
                                      );
                                    } else {
                                      Globals.categoryRef
                                          ?.doc(addCategory)
                                          .set({
                                        'category': addCategory,
                                      }).then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          Globals.customSnackBar(
                                            content:
                                                'Category $addCategory Added Successfully!',
                                          ),
                                        );
                                      });
                                    }

                                    setState(() {
                                      addCategoryController?.clear();
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
                          stream: Globals.categoryRef?.snapshots(),
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
                                print(snapshot.data!.docs[index]['category']);
                                var item = snapshot.data!.docs[index];
                                print(item);
                                newCat = snapshot.data!.docs[index]['category'];
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
                                                  ['category'],
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
                                                editCategory = snapshot.data!
                                                    .docs[index]['category'];
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
                                                            // controller: editCategoryController,
                                                            initialValue:
                                                                editCategory,
                                                            showCursor: true,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Edit Category',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                            ),
                                                            onChanged: (value) {
                                                              editCategory =
                                                                  value;
                                                              print(
                                                                  editCategory);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  btnOkOnPress: () {
                                                    print('Button Tapped');
                                                    print(editCategory);

                                                    Globals.categoryRef
                                                        ?.doc(snapshot.data!
                                                                .docs[index]
                                                            ['category'])
                                                        .delete()
                                                        .then((value) {
                                                      Globals.categoryRef
                                                          ?.doc(editCategory)
                                                          .set({
                                                        "category": editCategory
                                                      }).then((value) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          Globals
                                                              .customSnackBar(
                                                            content:
                                                                'Category Edited Successfully!',
                                                          ),
                                                        );
                                                      });
                                                    });

                                                    // Globals.categoryRef
                                                    //     ?.doc()
                                                    //     .update({
                                                    //   'category': editCategory
                                                    // }).then((value) {
                                                    //   ScaffoldMessenger.of(
                                                    //           context)
                                                    //       .showSnackBar(
                                                    //     Globals.customSnackBar(
                                                    //       content:
                                                    //           'Category Edited Successfully!',
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

                                              Globals.categoryRef
                                                  ?.doc(snapshot.data!
                                                      .docs[index]['category'])
                                                  .delete()
                                                  .then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  Globals.customSnackBar(
                                                    content:
                                                        'Category Removed Successfully!',
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

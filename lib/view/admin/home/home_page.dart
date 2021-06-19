import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // getUid();
    otherInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: Globals.userRef.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data?.docs.length);
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var length = snapshot.data!.docs.length.toString();

                      return Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                length,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Users',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: Globals.videoRef!.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data?.docs.length);
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var length = snapshot.data!.docs.length.toString();

                      return Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                length,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Teachers',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: Globals.classRef!.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data?.docs.length);
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var length = snapshot.data!.docs.length.toString();

                      return Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                length,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Students',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: Globals.otherRef!.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data?.docs.length);
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var length = snapshot.data!.docs.length.toString();

                      var data = snapshot.data!.docs;
                      var downloads = data[0]['downloads'];

                      return Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                downloads.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Subjects',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     StreamBuilder<QuerySnapshot>(
              //       stream: Globals.subjectRef!.snapshots(),
              //       builder: (BuildContext context,
              //           AsyncSnapshot<QuerySnapshot> snapshot) {
              //         print(snapshot.data?.docs.length);
              //         if (snapshot.hasError) {
              //           return Text('Something went wrong');
              //         }
              //
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         }
              //
              //         var length = snapshot.data!.docs.length.toString();
              //
              //         return Card(
              //           elevation: 10,
              //           clipBehavior: Clip.antiAlias,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //           child: Container(
              //             padding: EdgeInsets.all(10),
              //             width: MediaQuery.of(context).size.width / 4,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   'Subjects',
              //                   style: TextStyle(
              //                       fontSize: 20, fontWeight: FontWeight.bold),
              //                 ),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text(
              //                   length,
              //                   style: TextStyle(fontSize: 20),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //     StreamBuilder<QuerySnapshot>(
              //       stream: Globals.videoRef!.snapshots(),
              //       builder: (BuildContext context,
              //           AsyncSnapshot<QuerySnapshot> snapshot) {
              //         print("Why it's printing 0");
              //         print(snapshot.data?.docs.length);
              //         if (snapshot.hasError) {
              //           return Text('Something went wrong');
              //         }
              //
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         }
              //
              //         var length = snapshot.data!.docs.length.toString();
              //
              //         return Card(
              //           elevation: 10,
              //           clipBehavior: Clip.antiAlias,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //           child: Container(
              //             padding: EdgeInsets.all(10),
              //             width: MediaQuery.of(context).size.width / 4,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   'Videos',
              //                   style: TextStyle(
              //                       fontSize: 20, fontWeight: FontWeight.bold),
              //                 ),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text(
              //                   length,
              //                   style: TextStyle(
              //                     fontSize: 20,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  otherInfo() async {
    final snapshot = await Globals.otherRef!.get();
    if (snapshot.docs.length == 0) {
      await Globals.otherRef!.add({
        'downloads': 0,
      }).then((value) {
        print('Other Info Added Successfully!');
      });
    } else {
      print('Collection Already Exists');
    }
  }

  Future<DocumentSnapshot> getUid() async {
    await Future.delayed(Duration(seconds: 2));
    var firebaseUser = Globals.auth.currentUser;
    var uid = Globals.userRef.doc(firebaseUser!.uid).get();
    uid.then((value) {
      print(value['uid']);
      print(value['uid']);
    });
    print(uid);
    return uid;
  }

  Future<void> getDocument() {
    return Globals.userRef.doc(Globals.auth.currentUser!.uid).get().then(
          (value) {},
        );
  }
}

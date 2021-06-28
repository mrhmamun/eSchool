import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  // final String chatUid = 'oXZNUuDzWQdfQt37XZhuivglE5Q2';
  //
  // ChatScreen({this.chatUid});

  // final AuthImplementation auth;
  // final VoidCallback signedOut;
  // ChatScreen({
  //   this.auth,
  //   this.signedOut,
  // });
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  String? userName;

  @override
  void initState() {
    super.initState();
    // widget.auth.getCurrentUserEmail().then((email) {
    //   setState(() {
    //     final String userEmail = email;
    //     final endIndex = userEmail.indexOf("@");
    //     userName = userEmail.substring(0, endIndex);
    //   });
    // });

    getCurrentUserDetails();
    getChatUserDetails();
  }

  String? _userName;
  String? _userPhoto;
  String? _chatUserName;
  String? _chatUserPhoto;

  Future<Null> getCurrentUserDetails() async {
    return Globals.userRef
        .doc(Globals.auth.currentUser!.uid)
        .get()
        .then((data) {
      setState(() {
        _userName = data['displayName'];
        _userPhoto = data['photoURL'];
        print("Auth UserName $_userName");
        print("Auth UserPhoto $_userPhoto");
      });
    });
  }

  Future<Null> getChatUserDetails() async {
    return Globals.userRef
        .doc('oXZNUuDzWQdfQt37XZhuivglE5Q2')
        .get()
        .then((data) {
      setState(() {
        _chatUserName = data['displayName'];
        _chatUserPhoto = data['photoURL'];
        print("Auth UserName $_chatUserName");
        print("Auth UserPhoto $_chatUserPhoto");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2)),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: _chatUserPhoto ?? "",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                // height: 50,
                // width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          _chatUserName ?? "",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        // actions: <Widget>[
        // IconButton(
        //     icon: FaIcon(FontAwesomeIcons.signOutAlt),
        //     color: Colors.black,
        //     onPressed: logOut),
        // ],
      ),
      backgroundColor: antiFlashWhite,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5),
              child: StreamBuilder<QuerySnapshot>(
                  // stream: _firestore
                  //     .collection("messages")
                  //     .orderBy(
                  //       "timestamp",
                  //     )
                  //     .snapshots(),
                  stream: Globals.chatRef!
                      .doc(Globals.auth.currentUser!.uid)
                      .collection('chats')
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    List<DocumentSnapshot> docs = snapshot.data!.docs;

                    List<Widget> messages = docs
                        .map((doc) => Message(
                              user: doc['user'],
                              text: doc['text'],
                              timestamp: doc['timestamp'],
                              mine: _userName == doc['user'],
                            ))
                        .toList();
                    return ListView(
                      controller: scrollController,
                      children: messages,
                    );
                  }),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      onSubmitted: (value) => sendChat(),
                      controller: messageController,
                      cursorColor: cornFlowerBlue,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: antiFlashWhite,
                        hintText: "Type a message",
                        hintStyle:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.black,
                  ),
                  onPressed: sendChat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logOut() async {
    try {
      // await widget.auth.signOut();
      // widget.signedOut();
    } catch (e) {
      print("error :" + e.toString());
    }
  }

  // FirebaseFirestore.instance
  //     .collection('users')
  //     .where('language', arrayContainsAny: ['en', 'it'])
  //     .get()
  //     .then(...);

  Future<void> sendChat() async {
    if (messageController.text.length > 0) {
      // await _firestore.collection("messages").add({
      // await chatRef.add({
      //   'user': _userName,
      //   'text': messageController.text,
      //   'timestamp': FieldValue.serverTimestamp(),
      // });

      await Globals.chatRef!
          .doc(Globals.auth.currentUser!.uid)
          .collection('chats')
          .add({
        'user': _userName,
        'text': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
}

Color royalBlue = Color(0xff6f6ed6),
    cornFlowerBlue = Color(0xff7d7cda),
    buff = Color(0xfff9dd7a),
    antiFlashWhite = Color(0xffebeef3);

class Message extends StatelessWidget {
  final String? user, text;
  final bool? mine;
  final timestamp;
  Message({Key? key, this.user, this.text, this.mine, this.timestamp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment:
            mine == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user.toString(),
            style: TextStyle(
              color: mine == true ? Colors.black : royalBlue,
              fontSize: 13,
              fontFamily: 'Montserrat',
            ),
          ),
          Material(
            color: mine == true ? royalBlue : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                text.toString(),
                style: TextStyle(
                  color: mine == true ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

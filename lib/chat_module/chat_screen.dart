import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/chat_module/message_textfield.dart';
import 'package:women_safety_fyp/chat_module/single_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String? currentUserId;
  final String? friendId;
  final String? friendName;
  // final String friendImage;

  ChatScreen({
    this.currentUserId,
    this.friendId,
    this.friendName,
    // this.friendImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? name;

  TextEditingController genderC = TextEditingController();

  TextEditingController ageC = TextEditingController();

  TextEditingController symptomsC = TextEditingController();

  TextEditingController problemC = TextEditingController();

  TextEditingController timeC = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? stt;
  String? stt2;

  bool hide = false;
  // String? type;
  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)

        // .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          // stt = e['mode'];
          stt = value.data()!['mode'];
          // if (stt == 'resolved') {
          //   hide = true;
          // }
          print(stt);
        });
      }

      //totalMsgs = value.docs.length;
    });
  }

  getStatus2() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendId)

        // .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          // stt = e['mode'];
          stt2 = value.data()!['mode'];
          // if (stt2 == 'resolved') {
          //   // hide = true;
          // }
          print(stt);
        });
      }

      //totalMsgs = value.docs.length;
    });
  }

  checkStatus() {
    if (stt == 'resolved' && stt2 == "resolved") {
      print("ok $stt");
      setState(() {
        hide = true;
      });
    }
  }

  @override
  void initState() {
    // getStatus();
    getStatus();
    getStatus2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 248, 133, 172),
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset(
                  'images/security.png',
                  height: 40,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Center(
                child: Text(
                  widget.friendName!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.currentUserId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy(
                        "date",
                        descending: true,
                      )
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length < 1) {
                        return Center(
                          child: Text('talk with your guardian'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data!.docs[index]['senderId'] ==
                              widget.currentUserId;
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (v) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.currentUserId!)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .collection('chats')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete()
                                  .then((value) {
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(widget.currentId)
                                //     .collection('messages')
                                //     .doc(widget.friendId)
                                //     .set({
                                //   'last_msg': message,
                                // });
                              });

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.friendId)
                                  .collection('messages')
                                  .doc(widget.currentUserId!)
                                  .collection("chats")
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete()
                                  .then((value) {
                                // FirebaseFirestore.instance
                                //     .collection('users')
                                //     .doc(widget.friendId)
                                //     .collection('messages')
                                //     .doc(widget.currentId)
                                //     .set({"last_msg": message});
                              });
                            },
                            child: SingleMessage(
                              message: snapshot.data!.docs[index]['message'],
                              date: snapshot.data!.docs[index]['date'],
                              isMe: isMe,
                              friendname: widget.friendName,
                              myname: FirebaseAuth
                                  .instance.currentUser!.displayName,
                              type: snapshot.data!.docs[index]['type'],
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            MessageTextField(
              widget.currentUserId!,
              widget.friendId!,
              hide,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, String message, String senderId, String type,
      BuildContext context) {
    return type == "text"
        ? Container(
            width: size.width,
            alignment: senderId == FirebaseAuth.instance.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 248, 133, 172),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: senderId == FirebaseAuth.instance.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: message,
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: message != "" ? null : Alignment.center,
                child: message != ""
                    ? Image.network(
                        message,
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//
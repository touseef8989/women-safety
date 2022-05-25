import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/chat_module/chat_screen.dart';
import 'package:women_safety_fyp/screens/main_show_screens/landing_screen.dart';
import 'package:women_safety_fyp/widgets/doctor_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuardianHomeScreen extends StatefulWidget {
  @override
  State<GuardianHomeScreen> createState() => _GuardianHomeScreenState();
}

class _GuardianHomeScreenState extends State<GuardianHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // getStatus();
    return Scaffold(
      drawer: GuardianDrawer(),
      appBar: AppBar(
        title: Text("All Users"),
        actions: [
          IconButton(
            onPressed: () async {
              // await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LandingScren()),
                  (route) => false);
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //  Future.delayed(Duration(seconds: 3),(){}),
            // Column(
            //   children: stt!.map((e) => Text(e)).toList(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => ResolvedHistoryScreen(),
            //           ));
            //     },
            //     child: Container(
            //       height: 70,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //         color: Colors.amber,
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Center(child: Text("Resolved cases History")),
            //     ),
            //   ),
            // ),

            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('type', isEqualTo: 'user')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final d = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage:
                                      AssetImage('images/woman.png'),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  d['name'],
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                  currentUserId: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  friendId: d.id,
                                                  friendName: d['name'])));
                                    },
                                    icon: Icon(Icons.chat)),
                              ),
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

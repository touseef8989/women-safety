import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/admin/admin_check_doc_detail.dart';
import 'package:women_safety_fyp/screens/admin/admin_check_patient.dart';
import 'package:women_safety_fyp/screens/admin/admin_doctor_verify.dart';
import 'package:women_safety_fyp/screens/admin/admin_drawer.dart';
import 'package:women_safety_fyp/screens/admin/admin_resolved_cases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../main_show_screens/landing_screen.dart';
import 'admin_view_profile.dart';

class AdminMainScreen extends StatefulWidget {
  String? userid;

  AdminMainScreen({this.userid});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int totalDoctors = 0;
  getDoctors() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      setState(() {
        totalDoctors = value.docs.length;
      });
    });
  }

  int totalPatients = 0;
  getPatients() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'patient')
        .get()
        .then((value) {
      setState(() {
        totalPatients = value.docs.length;
      });
    });
  }

  int totalMsgs = 0;
  getMsgs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'patient')
        .where('mode', isEqualTo: 'resolved')
        // .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      setState(() {
        totalMsgs = value.docs.length;
      });
    });
  }

  @override
  void initState() {
    getDoctors();
    getPatients();
    getMsgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getDoctors();
    // getPatients();
    // getMsgs();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Welcome Admin",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              children: [],
            ),
          ],
        ),
        drawer: AdminDrawer(),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ADMIN AREA",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AdminDoctorVerify()));
                        },
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.width * 0.4,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.4),
                          decoration: BoxDecoration(
                            color: Colors.primaries[Random().nextInt(16)]
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "All Doctors",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text("Total  $totalDoctors"),
                            ],
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Admincheckpatient()));
                        },
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.width * 0.4,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.4),
                          decoration: BoxDecoration(
                            color: Colors.primaries[Random().nextInt(16)]
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "All Patients",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text("Total $totalPatients"),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AdminResolvedHistoryScreen()));
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.width * 0.6,
                        minWidth: MediaQuery.of(context).size.width * 0.1,
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.primaries[Random().nextInt(16)]
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resolved Cases",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("Total $totalMsgs"),
                        ],
                      )),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (_) => Admincheckpatient()));
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.primaries[Random().nextInt(16)]
                //           .withOpacity(0.4),
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //     child: Center(child: Text("All Doctors")),
                //   ),
                // ),
              ],
            )
            //  StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection('users')
            //       .where('type', isEqualTo: 'doctor')
            //       .snapshots(),
            //   builder:
            //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (!snapshot.hasData) {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //     return ListView.builder(
            //       itemCount: snapshot.data!.docs.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         final d = snapshot.data!.docs[index];
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(6),
            //                   border: Border.all(color: Colors.grey.shade400)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: ListTile(
            //                   leading: CircleAvatar(
            //                     radius: 20.0,
            //                     backgroundImage:
            //                         AssetImage('images/patient_login.png'),
            //                     backgroundColor: Colors.transparent,
            //                   ),
            //                   title: Text(
            //                     d['name'],
            //                   ),
            //                   // trailing: IconButton(
            //                   //     onPressed: () {
            //                   //       Navigator.push(
            //                   //           context,
            //                   //           MaterialPageRoute(
            //                   //               builder: (_) => ChatScreen(
            //                   //                   currentUserId: FirebaseAuth
            //                   //                       .instance.currentUser!.uid,
            //                   //                   friendId: d.id,
            //                   //                   friendName: d['name'])));
            //                   //     },
            //                   //     icon: Icon(Icons.chat)),
            //                 ),
            //               )),
            //         );
            //       },
            //     );
            //   },
            // ),

            ),
      ),
    );
  }
}

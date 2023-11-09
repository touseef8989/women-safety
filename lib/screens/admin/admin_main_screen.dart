import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/admin/admin_view_user_record.dart';
import 'package:women_safety_fyp/screens/admin/admin_view_gurdian_record.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AdminMainScreen extends StatefulWidget {
  final String? userid;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 248, 133, 172),
          centerTitle: true,
          title: const Text(
            "Welcome Admin",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdminViewGurdianRecord()));
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.width * 0.4,
                            minWidth: MediaQuery.of(context).size.width * 0.4),
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
                              "Gurdian-Record",
                              style: TextStyle(fontSize: 20),
                            ),
                            // Text("Total  $totalDoctors"),
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
                                builder: (_) => AdminViewUserRecord()));
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.width * 0.4,
                            minWidth: MediaQuery.of(context).size.width * 0.4),
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
                              "User-Record",
                              style: TextStyle(fontSize: 20),
                            ),
                            // Text("Total $totalPatients"),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

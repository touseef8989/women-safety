import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/admin/admin_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main_show_screens/landing_screen.dart';
import 'admin_check_doc_detail.dart';
import 'admin_view_profile.dart';

class Admincheckpatient extends StatelessWidget {
  const Admincheckpatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Admin-view-patient",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: AdminDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'patient')
            .snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('loading...'));
          }
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final res = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade400)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${res['name']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Divider(),
                            Text("email ${res['email']}"),
                          ],
                        ),
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

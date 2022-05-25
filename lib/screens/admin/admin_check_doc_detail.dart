import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_fyp/screens/admin/admin_doctor_verify.dart';
import 'package:women_safety_fyp/screens/admin/admin_drawer.dart';
import '../main_show_screens/landing_screen.dart';
import 'admin_check_patient.dart';
import 'admin_view_profile.dart';

class Admincheckdoc extends StatelessWidget {
  const Admincheckdoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Admin-view-doctor",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('type', isEqualTo: 'doctor')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          border: Border.all(color: Colors.grey.shade400)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                                AssetImage('images/patient_login.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(
                            d['name'],
                          ),
                          trailing: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AdminDoctorVerify()));
                              },
                              child: Text('verify')),
                        ),
                      )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

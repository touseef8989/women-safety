import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final snap = snapshot.data!.docs.first;

            return Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.deepOrange, Colors.pinkAccent])),
                    child: Container(
                      width: double.infinity,
                      height: 250.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                "images/doc.png",
                              ),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Doctor ${snap['name']}",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            snap['specialization'],
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Info:",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0),
                          ),
                        ),
                        Text(
                          snap['info'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "email:",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0),
                          ),
                        ),
                        Text(
                          snap['email'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "phone:",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0),
                          ),
                        ),
                        Text(
                          snap['phone'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "address:",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0),
                          ),
                        ),
                        Text(
                          snap['address'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            );
          }),
    );
  }
}

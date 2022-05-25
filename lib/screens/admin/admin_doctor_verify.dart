import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/widgets/eco_button.dart';
import 'package:women_safety_fyp/widgets/in_app_webview.dart';
import 'package:flutter/material.dart';

class AdminDoctorVerify extends StatefulWidget {
  const AdminDoctorVerify({Key? key}) : super(key: key);

  @override
  State<AdminDoctorVerify> createState() => _AdminDoctorVerifyState();
}

class _AdminDoctorVerifyState extends State<AdminDoctorVerify> {
  getAllDoctors() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("verify doctor"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'doctor')
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
                                alignment: Alignment.center,
                                child: Text(
                                  "Doctor ${res['name']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Divider(),
                            Text("PMC_NUMBER : ${res['pmc_number']}"),
                            Text("Info : ${res['info']}"),
                            Text("Specialization : ${res['specialization']}"),
                            Text("Address : ${res['address']}"),
                            Text(
                                "Current verification status : ${res['status']}"),
                            SwitchListTile(
                                title: Text("Change verification status"),
                                value: res['status'],
                                onChanged: (v) {
                                  setState(() {
                                    // res['status'] != res['status'];
                                    if (res['status'] == false) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(res.id)
                                          .update({"status": true});
                                      // res['status'] == true;
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(res.id)
                                          .update({"status": false});
                                    }
                                  });
                                }),
                            Text(
                              'To verify doctor click below button and enter pmc number',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text("phone ${res['phone']}"),
                            Text("email ${res['email']}"),
                            EcoButton(
                              isLoginButton: true,
                              title: "Verifty",
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => InAppWebViewScreen()));
                              },
                            ),
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

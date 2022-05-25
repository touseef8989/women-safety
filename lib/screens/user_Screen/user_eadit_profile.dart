import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:women_safety_fyp/utils/styles.dart';
import 'package:women_safety_fyp/widgets/eco_button.dart';
import 'package:women_safety_fyp/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserEditProfile extends StatefulWidget {
  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  TextEditingController eaditnamec = TextEditingController();
  TextEditingController eaditemailc = TextEditingController();
  TextEditingController eaditpasswordc = TextEditingController();

  // edit() async {
  //   var user = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance.collection("Patient").doc(user).update({
  //     "name": namec.text,
  //     "email": emailc.text,
  //     "password": passwordc.text,
  //   });
  // }
  // updateprofiledata() {
  //   setState(() {
  //     eaditemailc.text.trim().length < 3 || eaditnamec.text.isEmpty
  //         ? eaditnamec = false
  //         : eaditnamec = true;
  //     eaditemailc.text.trim().length > 50
  //         ? eaditemailc = false
  //         : eaditemailc = true;
  //     eaditpasswordc.text.trim().length < 8 || eaditpasswordc.text.isEmpty
  //         ? eaditpasswordc = false
  //         : eaditpasswordc = true;
  //   });
  //   if()
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Title(
                  color: Colors.black,
                  child: Text(
                    "Update Your Profile here....",
                    style: ktitlestyle,
                  ),
                ),
              ),
              EcoTextField(
                check: true,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "update your name like (areeb)";
                  }
                  return null;
                },
                inputAction: TextInputAction.next,
                controller: eaditnamec,
                hintText: "Update your name...",
                icon: const Icon(Icons.edit),
              ),
              EcoTextField(
                check: true,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "update your email like (areeb@gmail.com)";
                  }
                  return null;
                },
                inputAction: TextInputAction.next,
                controller: eaditemailc,
                hintText: "Update your email",
                icon: const Icon(Icons.edit),
              ),
              EcoTextField(
                check: true,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "update your password like (6 character)";
                  }
                  return null;
                },
                inputAction: TextInputAction.next,
                controller: eaditpasswordc,
                hintText: "Update your password...",
                icon: const Icon(Icons.edit),
              ),
              const SizedBox(
                height: 50,
              ),
              EcoButton(
                title: "Update",
                isLoading: false,
                isLoginButton: true,
                // onPress: updateprofiledata,
              ),
              EcoButton(
                title: "Logout",
                isLoading: false,
                isLoginButton: true,
                onPress: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.back();
                  });

                  // Navigator.Push
                },
                // onPress: updateprofiledata,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/admin/admin_main_screen.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_login_screen.dart';
import 'package:women_safety_fyp/widgets/eco_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class AdminSignUp extends StatefulWidget {
  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  // const WebLoginScreen({Key? key}) : super(key: key);
  TextEditingController userNameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;
  bool ispassword = true;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseFirestore.instance.collection('admin').get().then((value) {
        print('${value.docs.first['gmail']}');

        if (value.docs.first['gmail'] == userNameC.text &&
            value.docs.first['password'] == passwordC.text) {
          print("OKKK");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AdminMainScreen()));
        } else {
          setState(() {
            formStateLoading = false;
          });
          showDialog(
              context: context,
              builder: (_) {
                return EcoDialogue(title: 'some values are not correct');
              });
        }
      });
      // await FirebaseServices.adminSignIn(userNameC.text).then((value) async {
      //   if (!value.exists) {
      //     print("OOOOOOOOOOOOOOOOOOOOOOOOKKKKKKKKKK");
      //   }
      //   if (value['username'] == userNameC.text &&
      //       value['password'] == passwordC.text) {
      //     try {
      //       UserCredential user =
      //           await FirebaseAuth.instance.signInAnonymously();
      //       if (user != null) {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (_) => AdminMainScreen()));
      //       }
      //     } catch (e) {
      //       setState(() {
      //         formStateLoading = false;
      //       });
      //       showDialog(
      //           context: context,
      //           builder: (_) {
      //             return EcoDialogue(
      //               title: e.toString(),
      //             );
      //           });
      //     }
      //   }
      // });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.black, width: 3),
              // borderRadius: BorderRadius.circular(12)

              ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "WELCOME ADMIN",
                    style: EcoStyle.boldStyle,
                  ),
                  const Text(
                    "Log in to your Account",
                    style: EcoStyle.boldStyle,
                  ),
                  EcoTextField(
                    controller: userNameC,
                    hintText: "UserName...",
                    maxLines: 1,
                    validate: (v) {
                      if (!v!.contains("@gmail.com") && v.length < 0) {
                        return "email is badly formated";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: passwordC,
                    isPassowrd: ispassword,
                    maxLines: 1,
                    hintText: "Password...",
                    icon: IconButton(
                      onPressed: () {
                        setState(() {
                          ispassword = !ispassword;
                        });
                      },
                      icon: ispassword
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "password should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoButton(
                    isLoginButton: true,
                    title: "LOGIN",
                    isLoading: formStateLoading,
                    onPress: () {
                      // submit(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AdminMainScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

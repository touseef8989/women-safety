import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_sing-up.dart';
import 'package:women_safety_fyp/screens/guardian_screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_signup_screen.dart';
import 'package:women_safety_fyp/services/share_preff.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class GuardianLoginScreen extends StatefulWidget {
  const GuardianLoginScreen({Key? key}) : super(key: key);
  @override
  State<GuardianLoginScreen> createState() => _GuardianLoginScreenState();
}

class _GuardianLoginScreenState extends State<GuardianLoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool ispassword = true;

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        print("Login Sucessfull");
        _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
            (value) => userCredential.user!.updateDisplayName(value['name']));
        if (userCredential != null) {
          setState(() {
            formStateLoading = false;
          });
          MyPrefferenc.saveEmail(emailC.text);

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => GuardianHomeScreen()));
        }

        return userCredential.user;
      } catch (e) {
        ecoDialogue(e.toString());
        print(e);
        return null;
      }
      // String? accountstatus = await FirebaseServices.signInAccountDoctorLogin(
      //     emailC.text, passwordC.text);
      // //print(accountstatus);
      // if (accountstatus != null) {
      //   ecoDialogue(accountstatus);
      //   setState(() {
      //     formStateLoading = false;
      //   });
      // } else {
      //   _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
      //       (value) => userCredential.user!.updateDisplayName(value['name']));
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (_) => DoctorHomeScreen()));
      // }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Guardian Login",
                textAlign: TextAlign.center,
                style: EcoStyle.boldStyle,
              ),
              const SizedBox(
                height: 50,
              ),
              // Image.asset(
              //   "images/patient_login.png",
              //   height: 150,
              // ),
              Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        EcoTextField(
                          controller: emailC,
                          hintText: "Email...",
                          validate: (v) {
                            if (!v!.contains("@gmail.com") && v.length < 0) {
                              return "email is badly formated";
                            }
                            return null;
                          },
                        ),
                        EcoTextField(
                          controller: passwordC,
                          hintText: "Password...",
                          isPassowrd: ispassword,
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
                              return "pass should not be empty";
                            }
                            return null;
                          },
                        ),
                        EcoButton(
                          title: "LOGIN",
                          isLoading: formStateLoading,
                          isLoginButton: true,
                          onPress: () {
                            submit();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              EcoButton(
                title: "CREATE NEW ACCOUNT",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorSignupScreen(),
                    ),
                  );
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

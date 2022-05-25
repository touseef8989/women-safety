import 'package:women_safety_fyp/screens/guardian_screen/guardian-Login.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_sing-up.dart';
import 'package:women_safety_fyp/screens/user_Screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_login_screen.dart';
import 'package:flutter/material.dart';

import '../admin/admin_login.dart';

class LandingScren extends StatelessWidget {
  String? userid;
  LandingScren({this.userid});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN WITH YOUR ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // box(context, () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (_) => AdminSignUp()));
                // }, "LOGIN AS ADMIN"),
                box(context, () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => UserLogin()));
                }, "LOGIN AS USER"),
                box(context, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => GuardianLoginScreen()));
                }, "LOGIN AS GUARDIAN"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget box(BuildContext context, VoidCallback click, String? title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: click,
        child: Container(
          //width: double.infinity,
          constraints: BoxConstraints(minHeight: 130),
          decoration: BoxDecoration(
              color: Colors.purple,
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent.withOpacity(0.6),
              ]),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Text(
            "$title",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }
}

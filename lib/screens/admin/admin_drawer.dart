import 'package:women_safety_fyp/screens/admin/admin_check_doc_detail.dart';
import 'package:women_safety_fyp/screens/admin/admin_check_patient.dart';
import 'package:women_safety_fyp/screens/admin/admin_main_screen.dart';
import 'package:women_safety_fyp/screens/admin/admin_view_profile.dart';
import 'package:women_safety_fyp/screens/main_show_screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset("images/admin_logo.jpg"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AdminMainScreen()));
            },
            child: Adminprofiledawer(
              icon: Icons.person,
              text: "Home",
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Admincheckdoc()));
            },
            child: Adminprofiledawer(
              icon: Icons.person,
              text: "Admin-view-doctor",
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {},
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Admincheckpatient()));
              },
              child: Adminprofiledawer(
                icon: Icons.person,
                text: "Admin view Patient",
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LandingScren()));
            },
            child: Adminprofiledawer(
              icon: Icons.lock,
              text: "Logout",
            ),
          ),
        ],
      ),
    );
  }
}

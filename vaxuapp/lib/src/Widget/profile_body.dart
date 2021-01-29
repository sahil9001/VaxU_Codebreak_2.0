import 'package:flutter/material.dart';
import 'package:vaxuapp/src/details_screen.dart';
import 'package:vaxuapp/src/help_screen.dart';
import 'package:vaxuapp/src/home_final_screen.dart';
import 'package:vaxuapp/src/home_screen.dart';
import 'package:vaxuapp/src/apply_for_vaccination.dart';
import 'package:vaxuapp/src/profile_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
              text: "My Details",
              icon: Icon(Icons.supervised_user_circle),
              press: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfileDetailsScreen()))
                  }),
          ProfileMenu(
              text: "Apply for Vaccination",
              icon: Icon(Icons.local_hospital),
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => VaccinationApply()));
              }),
          ProfileMenu(
              text: "Help Center",
              icon: Icon(Icons.help_center),
              press: () => {
                    
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HelpScreen()))
                  }),
          ProfileMenu(
            text: "Log Out",
            icon: Icon(Icons.exit_to_app_sharp),
            press: () => _handleLogout(),
          ),
        ],
      ),
    );
  }
}

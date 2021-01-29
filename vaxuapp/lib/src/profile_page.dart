import 'package:flutter/material.dart';

import 'package:vaxuapp/src/Widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

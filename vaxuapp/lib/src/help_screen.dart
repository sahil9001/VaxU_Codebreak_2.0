import 'package:flutter/material.dart';
import 'package:vaxuapp/src/profile_page.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop(MaterialPageRoute(
              builder: (BuildContext context) => ProfileScreen()));
        },
      ),
    ));
  }
}

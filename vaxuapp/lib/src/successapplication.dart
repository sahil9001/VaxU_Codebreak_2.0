import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/profile_page.dart';

class SuccessApplication extends StatefulWidget {
  @override
  _SuccessApplicationState createState() => _SuccessApplicationState();
}

class _SuccessApplicationState extends State<SuccessApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,size: 70,color: Colors.green,),
            SizedBox(height: 20,),
            Text(
              "You've already applied for vaccination!",
              style: TextStyle(color: Colors.green, fontSize: 40),
              textAlign: TextAlign.center,
            )
          ],
        )),
      ),
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop(context);
          });
        },
      ),
      actions: <Widget>[],
    );
  }
}

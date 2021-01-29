import 'package:flutter/material.dart';
import 'package:vaxuapp/landing.dart';
import 'package:vaxuapp/src/home_final_screen.dart';
import 'package:vaxuapp/src/home_screen.dart';
import 'package:vaxuapp/src/loginPage.dart';
import 'package:vaxuapp/src/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/welcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Covid Demo',
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeFinalScreen(),
        '/profile': (context) => ProfileScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

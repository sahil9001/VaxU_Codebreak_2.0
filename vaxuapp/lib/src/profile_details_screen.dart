import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/models/user.dart';
import 'package:vaxuapp/src/profile_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<UserInfo> fetchUserInfo() async {
  String token = await User().getToken();
  final response = await http.get('http://${URL_HOST}/api/users/info/',
      headers: {'accept': 'application/json', "Authorization": "$token"});
  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class UserInfo {
  final String username;
  final String phone;
  final String email;
  final String blood_group;
  final int age;
  final String city;
  final String country;
  final bool is_kyc;
  final bool applied_for_vaccination;
  final bool is_vaccinated;

  UserInfo(
      {this.username,
      this.phone,
      this.email,
      this.blood_group,
      this.age,
      this.city,
      this.country,
      this.is_kyc,
      this.applied_for_vaccination,
      this.is_vaccinated});
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return new UserInfo(
        username: json['username'],
        phone: json['phone'],
        email: json['email'],
        blood_group: json['blood_group'],
        age: json['age'],
        city: json['city'],
        country: json['country'],
        is_kyc: json['is_kyc'],
        applied_for_vaccination: json['applied_for_vaccination'],
        is_vaccinated: json['is_vaccinated']);
  }
}

class ProfileDetailsScreen extends StatefulWidget {
  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  Future<UserInfo> futureUserInfo;
  @override
  void initState() {
    super.initState();
    futureUserInfo = fetchUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<UserInfo>(
          future: futureUserInfo,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "User Details",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Username",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.username,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Phone number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.phone,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.email,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Blood Group",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.blood_group,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Age",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: (snapshot.data.age).toString(),
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "City",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.city,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Country",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.country,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Applied for vaccination status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        snapshot.data.applied_for_vaccination
                                            ? "Yes"
                                            : "No",
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Vaccinated?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: snapshot.data.is_vaccinated
                                        ? "Yes"
                                        : "No",
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                    ],
                  ));
            else {
              return Text("errors");
            }
          },
        ),
      ),
    );
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = await User().getEmail();
    print(prefs.getString('email'));
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
          Navigator.of(context).pop(MaterialPageRoute(
              builder: (BuildContext context) => ProfileScreen()));
        },
      ),
      actions: <Widget>[],
    );
  }
}

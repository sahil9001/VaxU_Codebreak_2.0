import 'dart:io';

import 'package:vaxuapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:vaxuapp/src/home_final_screen.dart';
import 'package:vaxuapp/src/models/user.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VaccinatorsList {
  final List<Vaccinator> vaccinators;

  VaccinatorsList({
    this.vaccinators,
  });

  factory VaccinatorsList.fromJson(List<dynamic> parsedJson) {
    List<Vaccinator> vaccinators = new List<Vaccinator>();
    vaccinators = parsedJson.map((i) => Vaccinator.fromJson(i)).toList();
    return new VaccinatorsList(
      vaccinators: vaccinators,
    );
  }
}

Future<VaccinatorsList> fetchVaccinators() async {
  String token = await User().getToken();
  final response = await http.get(
    'http://${URL_HOST}/api/users/vaccinators/',
    headers: {'accept': 'application/json', "Authorization": "$token"},
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return VaccinatorsList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load hospitals');
  }
}

class Vaccinator {
  final String center_name;
  final bool is_available;
  final String org_description;
  final int vaccines_available;
  final String price;

  Vaccinator(
      {this.center_name,
      this.vaccines_available,
      this.is_available,
      this.org_description,
      this.price});

  factory Vaccinator.fromJson(Map<String, dynamic> json) {
    print(json['org_description']);
    return new Vaccinator(
        center_name: json['center_name'],
        is_available: json['is_available'],
        org_description: json['org_description'],
        vaccines_available: json['vaccines_available'],
        price: json['price']);
  }
}

//
class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Future<VaccinatorsList> futureVaccinators;

  @override
  void initState() {
    super.initState();
    futureVaccinators = fetchVaccinators();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildDetailsAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<VaccinatorsList>(
            future: futureVaccinators,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(children: buildList(snapshot)),
                );
              } else if (snapshot.hasError) {
                return Text("error");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  List<Widget> buildList(AsyncSnapshot snapshot) {
    List<Widget> lst = [];
    for (var key in snapshot.data.vaccinators) {
      lst.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 21),
              blurRadius: 53,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Centre name",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: kTextMediumColor,
                fontSize: 14,
              ),
            ),
            buildCaseNumber(
              context,
              data: key.center_name,
              percentage: "5.2",
            ),
            SizedBox(height: 15),
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: kTextMediumColor,
                fontSize: 14,
              ),
            ),
            Text(
              key.org_description,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: kTextMediumColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Raipur, Chhatissgarh",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: kTextMediumColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildInfoTextWithBoolean(
                  availibility: key.is_available,
                  title: "Available",
                ),
                buildInfoTextWithPercentage(
                  percentage: key.vaccines_available.toString(),
                  title: "Vaccines Available",
                ),
                buildInfoTextWithPercentage(
                  percentage: key.price,
                  title: "Vaccine Price",
                ),
              ],
            )
          ],
        ),
      ));
      lst.add(SizedBox(height: 20));
    }
    return lst;
  }

  RichText buildInfoTextWithBoolean({String title, bool availibility}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title\n",
            style: TextStyle(
              color: kTextMediumColor,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: availibility == true ? "Yes" : "No",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title\n",
            style: TextStyle(
              color: kTextMediumColor,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: percentage,
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Row buildCaseNumber(BuildContext context, {String data, String percentage}) {
    return Row(
      children: <Widget>[
        Text(
          data,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: kPrimaryColor, height: 1.2),
        ),
      ],
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HomeFinalScreen()));
        },
      ),
      actions: <Widget>[],
    );
  }
}

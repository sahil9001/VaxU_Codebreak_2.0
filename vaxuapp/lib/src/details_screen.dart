import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/Widget/weeklyChart.dart';
import 'package:flutter/material.dart';
import 'package:vaxuapp/src/home_final_screen.dart';
import 'package:vaxuapp/src/home_screen.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<TT> fetchAlbum() async {
  final response = await http.get('https://api.covid19india.org/v4/data.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return TT.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class TT {
  final Total tt;

  TT({this.tt});

  factory TT.fromJson(Map<String, dynamic> json) => TT(
        tt: Total.fromJson(json["CT"]),
      );
}

class Total {
  final CovidDetails total;

  Total({this.total});
  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(total: CovidDetails.fromJson(json['total']));
  }
}

class CovidDetails {
  final int confirmed;
  final int recovered;
  final int deaths;
  final int tested;

  CovidDetails({this.confirmed, this.recovered, this.deaths, this.tested});

  factory CovidDetails.fromJson(Map<String, dynamic> json) {
    return CovidDetails(
        confirmed: json['confirmed'] as int,
        recovered: json['recovered'],
        deaths: json['deceased'],
        tested: json['tested']);
  }
}

//
class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<TT> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildDetailsAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<TT>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                                "City Cases",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            buildTitleWithMoreIcon(),
                            SizedBox(height: 15),
                            buildCaseNumber(
                              context,
                              data: snapshot.data.tt.total.confirmed,
                              percentage: "10.5%",
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Raipur, Chhatissgarh",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kTextMediumColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                buildInfoTextWithPercentage(
                                  percentage:
                                      ((snapshot.data.tt.total.recovered /
                                                  snapshot.data.tt.total
                                                      .confirmed) *
                                              100.0)
                                          .toStringAsFixed(3),
                                  title: "Recovery Rate",
                                ),
                                buildInfoTextWithPercentage(
                                  percentage: ((snapshot.data.tt.total.deaths /
                                              snapshot
                                                  .data.tt.total.confirmed) *
                                          100.0)
                                      .toStringAsFixed(3),
                                  title: "Death Rate",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Help around you",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              buildHelp("Dial 676 for groceries\n","\nEvery vegetable you need is just a call away!"),
                              buildHelpLeft("Dial 677 for medicines\n","\nMedicines available at your footsteps!"),
                              buildHelpEmergency("Dial 112 in Emergency\n","\nDial only when there's an emergency!"),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              else if (snapshot.hasError) {
                return Text("error");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Container buildHelp(String content,String description) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$content",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "$description",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: Icon(Icons.local_grocery_store,size: 100,color: Colors.white,),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  Container buildHelpEmergency(String content,String description) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$content",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "$description",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: Icon(Icons.local_hospital_rounded,size: 100,color: Colors.white,),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }
Container buildHelpLeft(String content,String description) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              right: MediaQuery.of(context).size.width * .4,
              top: 20,
              left: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$content",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "$description",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 205,vertical: 10),
            child: Icon(Icons.healing,size: 100,color: Colors.white,),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
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
            text: "$percentage% \n",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: kTextMediumColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Row buildCaseNumber(BuildContext context, {int data, String percentage}) {
    return Row(
      children: <Widget>[
        Text(
          "$data ",
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: kPrimaryColor, height: 1.2),
        ),
        Text(
          "$percentage%",
          style: TextStyle(color: kPrimaryColor),
        ),
        SvgPicture.asset("assets/icons/increase.svg")
      ],
    );
  }

  Row buildTitleWithMoreIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        
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

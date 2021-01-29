import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/details_screen.dart';
import 'package:vaxuapp/src/Widget/infoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

//
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
        tt: Total.fromJson(json["TT"]),
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
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<TT> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  final formatter = new NumberFormat("##,###");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
//wrap singlechildscrollview for correct displaying in small density devices
      body: SingleChildScrollView(
        child: FutureBuilder<TT>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.03),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: <Widget>[
                        InfoCard(
                          title: "Confirmed Cases",
                          iconColor: Color(0xFFFF8C00),
                          effectedNum: snapshot.data.tt.total.confirmed,
                          type: 1,
                          press: () {},
                        ),
                        InfoCard(
                          title: "Total Deaths",
                          iconColor: Color(0xFFFF2D55),
                          effectedNum: snapshot.data.tt.total.deaths,
                          type: 2,
                          press: () {},
                        ),
                        InfoCard(
                          title: "Total Recovered",
                          iconColor: Color(0xFF50E3C2),
                          effectedNum: snapshot.data.tt.total.recovered,
                          type: 1,
                          press: () {},
                        ),
                        InfoCard(
                          title: "Total Tested",
                          iconColor: Color(0xFF5856D6),
                          effectedNum: snapshot.data.tt.total.tested,
                          type: 1,
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Preventions",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          buildPreventation(),
                          SizedBox(height: 40),
                          buildHelpCard(context)
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("error");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Wash Hands",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Use Masks",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Clean Disinfect",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
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
                    text: "Dial 901 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}

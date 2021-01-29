import 'package:flutter/material.dart';
import 'package:vaxuapp/src/Widget/beizerContainer.dart';
import 'package:vaxuapp/src/loginPage.dart';
import 'package:vaxuapp/src/models/api_error.dart';
import 'package:vaxuapp/src/models/api_response.dart';
import 'package:vaxuapp/src/services/api.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiResponse _apiResponse = new ApiResponse();
  String _username = "";
  String _email = "";
  String _phone = "";
  String _password = "";
  String _blood_group = "";
  String _age = "";
  String _city = "";
  String _country = "";
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, String valuetoset,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              obscureText: isPassword,
              key: Key("$valuetoset"),
              onSaved: (String value) {
                valuetoset = value;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _handleRegister,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF0D8E53), Color(0xFF0D8E53)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xFF0D8E53),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Vax',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        TextSpan(
          text: 'U',
          style: TextStyle(color: Color(0xFF0D8E53), fontSize: 30),
        ),
      ]),
    );
  }

  void showInSnackBar(String value) {
    print(value);
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
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
                                key: Key("_username"),
                                onSaved: (String value) {
                                  _username = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Username is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              "Phone",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_phone"),
                                onSaved: (String value) {
                                  _phone = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Phone is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_email"),
                                onSaved: (String value) {
                                  _email = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              "Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_password"),
                                onSaved: (String value) {
                                  _password = value;
                                },
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_blood_group"),
                                onSaved: (String value) {
                                  _blood_group = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Blood group is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_city"),
                                onSaved: (String value) {
                                  _city = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'City is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_age"),
                                keyboardType: TextInputType.number,
                                onSaved: (String value) {
                                  _age = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Age is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
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
                              height: 5,
                            ),
                            TextFormField(
                                key: Key("_country"),
                                onSaved: (String value) {
                                  _country = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Country is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  void _handleRegister() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _apiResponse = await registerUser(_username, _password, _phone, _email,
          _blood_group, _age, _city, _country);
      if ((_apiResponse.ApiError as ApiError) == null) {
        _saveAndRedirectToLogin();
      } else {
        showInSnackBar((_apiResponse.ApiError as ApiError).error);
      }
    }
  }

  void _saveAndRedirectToLogin() {
    print(_phone);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}

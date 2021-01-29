import 'package:flutter/material.dart';
import 'package:vaxuapp/src/home_final_screen.dart';
import 'package:vaxuapp/src/home_screen.dart';
import 'package:vaxuapp/src/models/api_error.dart';
import 'package:vaxuapp/src/models/api_response.dart';
import 'package:vaxuapp/src/models/user.dart';
import 'package:vaxuapp/src/services/api.dart';
import 'package:vaxuapp/src/signup.dart';
import 'package:vaxuapp/src/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vaxuapp/src/Widget/beizerContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ApiResponse _apiResponse = new ApiResponse();
  String _password = "";
  String _username = "";
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage()));
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

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", (_apiResponse.Data as User).token);
    print(prefs.getString('token'));
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.Data as User));
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
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 50),
                        TextFormField(
                          key: Key("_username"),
                          decoration: InputDecoration(labelText: "Username"),
                          keyboardType: TextInputType.text,
                          onSaved: (String value) {
                            _username = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          key: Key("_password"),
                          decoration: InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onSaved: (String value) {
                            _password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        InkWell(
                            onTap: _handleSubmitted,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                      colors: [
                                        Color(0xFF0D8E53),
                                        Color(0xFF0D8E53)
                                      ])),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _facebookButton(),
                        SizedBox(height: height * .055),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      print(_username);
      _apiResponse = await authenticateUser(_username, _password);
      if ((_apiResponse.ApiError as ApiError) == null) {
        _saveAndRedirectToHome();
      } else {
        showInSnackBar((_apiResponse.ApiError as ApiError).error);
      }
    }
  }
}

// TODO Implement this library.
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/models/api_error.dart';
import 'package:vaxuapp/src/models/api_response.dart';
import 'package:vaxuapp/src/models/user.dart';
import 'package:vaxuapp/src/profile_page.dart';
import 'package:vaxuapp/src/successapplication.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class HospitalList {
  String name;
  String hospital_id;
  HospitalList({
    this.name,
    this.hospital_id
  });
}
class AppliedResponse {
  final bool applied_for_vaccination;
  AppliedResponse({this.applied_for_vaccination});
  factory AppliedResponse.fromJson(Map<String, dynamic> json) {
    return new AppliedResponse(
        applied_for_vaccination: json['applied_for_vaccination']);
  }
}

Future<AppliedResponse> fetchStatus() async {
  String token = await User().getToken();
  final response = await http.post(
    'http://${URL_HOST}/api/users/vaccinators/',
    headers: {'accept': 'application/json', "Authorization": "$token"},
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AppliedResponse.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<StreamedResponse> postEKYC(
    String firstname,
    String lastname,
    String gender,
    String date,
    File adhaar_image,
    File image,
    String adhaar_number,
    String hospital_id) async {
  String token = await User().getToken();
  String uploadURL = "http://${URL_HOST}/api/ekyc/register/";
  String filename = adhaar_image.path;
  String filename1 = image.path;
  var request = http.MultipartRequest('POST', Uri.parse(uploadURL));
  request.files
      .add(await http.MultipartFile.fromPath('adhaar_image', filename));
  request.files
      .add(await http.MultipartFile.fromPath('profile_image', filename1));
  request.headers["Authorization"] = token;
  request.fields["first_name"] = firstname;
  request.fields["last_name"] = lastname;
  request.fields["dob"] = date;
  request.fields["gender"] = gender;
  request.fields["adhaar_number"] = adhaar_number;
  request.fields["hospital_id"] = hospital_id;
  //
  var res = await request.send();
  return res;
}

class KycScreen extends StatefulWidget {
  @override
  _KycScreenState createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _genderItems = ['M', 'F'];
  List<HospitalList> _hospitalItems = [
    HospitalList(
      hospital_id: "2",
      name: "Balaji Hospital"
    ),
    HospitalList(
      hospital_id: "3",
      name: "Sarvodaya Hospital"
    ),
    HospitalList(
      hospital_id: "4",
      name: "Ambedkar Government Hospital"
    ),
    HospitalList(
      hospital_id: "5",
      name: "Krishna Hospital"
    ),
    HospitalList(
      hospital_id: "6",
      name: "Aryan Hospital"
    ),
    HospitalList(
      hospital_id: "7",
      name: "Sanjeeb Hospital"
    ),
    HospitalList(
      hospital_id: "8",
      name: "Sakshi Hospital"
    ),
    HospitalList(
      hospital_id: "9",
      name: "Kalyan Hospital"
    ),
    HospitalList(
      hospital_id: "10",
      name: "Suyash Hospital"
    ),
    HospitalList(
      hospital_id: "11",
      name: "Narayana Hospital"
    ),
  
  ];
  ApiResponse _apiResponse = new ApiResponse();
  String _firstname = "";
  String _lastname = "";
  String _gender = 'M';
  String _hospital_id = ""; 
  File _adhaar_image;
  File _image;
  Uri _adhaar_image_picked;
  Uri _image_picked;
  String _adhaar_number = "";
  final picker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  String _date = "";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = selectedDate.toString();
      });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image_picked = Uri.parse(pickedFile.path);
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage1() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _adhaar_image_picked = Uri.parse(pickedFile.path);
        _adhaar_image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
 @override
 void initState() {
    super.initState();
   _hospital_id = _hospitalItems[0].hospital_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Vaccine application form",
                  style: TextStyle(fontSize: 26.5, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "First Name (Should be official)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          key: Key("_firstname"),
                          onSaved: (String value) {
                            _firstname = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'First Name is required';
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
                        "Last Name (Should be official)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          key: Key("_lastname"),
                          onSaved: (String value) {
                            _lastname = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Last name is required';
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
                        "Adhaar number without spaces",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          key: Key("_adhaar_number"),
                          onSaved: (String value) {
                            _adhaar_number = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Adhaar number is required';
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
                        "Date of Birth (YYYY-MM-DD)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          key: Key("_date"),
                          onSaved: (String value) {
                            _date = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'DOB is required';
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
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Gender',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _gender == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _gender,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _gender = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _genderItems.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hospital",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Hospital',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _hospital_id,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _hospital_id = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _hospitalItems.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.hospital_id,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 100),
                  child: RaisedButton(
                    onPressed: _handleSubmit,
                    child: Text(
                      'Submit Form',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: FloatingActionButton(
                  child: Icon(Icons.credit_card), onPressed: getImage1)),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: FloatingActionButton(
                  child: Icon(Icons.camera), onPressed: getImage)),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      var res = await postEKYC(_firstname, _lastname, _gender, _date,
          _adhaar_image, _image, _adhaar_number,_hospital_id);
      if ((_apiResponse.ApiError as ApiError) == null) {
        if (res.statusCode == 201)
          showInSnackBar('Success');
        else if (res.statusCode == 400) showInSnackBar('Resubmit the adhaar card and proper details');
      } else {
        showInSnackBar((_apiResponse.ApiError as ApiError).error);
      }
    }
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
              builder: (BuildContext context) => ProfileScreen()));
        },
      ),
      actions: <Widget>[],
    );
  }
}

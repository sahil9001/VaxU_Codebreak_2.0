import 'dart:convert';
import 'dart:io';

import 'package:vaxuapp/constants.dart';
import 'package:vaxuapp/src/models/api_error.dart';
import 'package:vaxuapp/src/models/api_response.dart';
import 'package:vaxuapp/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://${URL_HOST}/";
Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<ApiResponse> authenticateUser(String username, String password) async {
  ApiResponse _apiResponse = new ApiResponse();

  try {
    final response = await http.post('${_baseUrl}api/users/login/', body: {
      'email': username,
      'password': password,
    });

    switch (response.statusCode) {
      case 202:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> registerUser(
    String username,
    String password,
    String phone,
    String email,
    String blood_group,
    String age,
    String city,
    String country) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    print(_baseUrl);
    final response = await http.post('${_baseUrl}api/users/register/', body: {
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "blood_group": blood_group,
      "age": age,
      "city": city,
      "country": country
    });
    print(response.body);
    switch (response.statusCode) {
      case 201:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> registerVaccUser(String firstname, String lastname,
    File profile_img, String dob, String gender, File adhaar_img) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.post('${_baseUrl}api/ekyc/register/', body: {
      "first_name": firstname,
      "last_name": lastname,
      "profile_image": profile_img,
      "dob": dob,
      "gender": gender,
      "adhaar_image": adhaar_img,
    });
    print(response.body);
    switch (response.statusCode) {
      case 201:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('${_baseUrl}user/$userId');

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

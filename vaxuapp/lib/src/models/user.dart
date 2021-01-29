import 'package:shared_preferences/shared_preferences.dart';

class User {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'username': username,
      'name': 'Peter Clarke',
      'lastLogin': "23 March 2020 03:34 PM",
      'email': 'x7uytx@mundanecode.com'
  }
  */
  String _username;
  String _name;
  String _email;
  String _token;
  String _blood_group;
  String _age;
  bool _applied_for_vaccination;
  bool _is_kyc;
  String _city;
  String _country;
  bool _is_vaccinated;
  User(
      {String username,
      String name,
      String email,
      String token,
      String blood_group,
      String age,
      bool applied_for_vaccination,
      bool is_kyc,
      String city,
      String country,
      bool is_vaccinated}) {
    this._username = username;
    this._name = name;
    this._email = email;
    this._token = token;
    this._blood_group = blood_group;
    this._age = age;
    this._applied_for_vaccination = applied_for_vaccination;
    this._is_kyc = is_kyc;
    this._city = city;
    this._country = country;
    this._is_vaccinated = is_vaccinated;
  }

  // Properties
  String get username => _username;
  set username(String username) => _username = username;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  String get token => _token;
  set token(String token) => _token = token;
  String get blood_group => _blood_group;
  set blood_group(String blood_group) => _blood_group = blood_group;
  String get age => _age;
  set age(String age) => _age = age;
  bool get applied_for_vaccination => _applied_for_vaccination;
  set applied_for_vaccination(bool applied_for_vaccination) =>
      _applied_for_vaccination = applied_for_vaccination;
  bool get is_kyc => _is_kyc;
  set is_kyc(bool is_kyc) => _is_kyc = is_kyc;
  String get city => _city;
  set city(String city) => _city = city;
  String get country => _country;
  set country(String country) => _country = country;
  bool get is_vaccinated => _is_vaccinated;
  set is_vaccinated(bool is_vaccinated) => _is_vaccinated = is_vaccinated;

  // create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _name = json['name'];
    _email = json['email'];
    _token = json['token'];
    _blood_group = json['blood_group'];
    _age = json['age'];
    _applied_for_vaccination = json['applied_for_vaccination'];
    _is_kyc = json['is_kyc'];
    _city = json['city'];
    _country = json['country'];
    _is_vaccinated = json['is_vaccinated'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['name'] = this._name;
    data['email'] = this._email;
    data['token'] = this._token;
    data['blood_group'] = this._blood_group;
    data['age'] = this._age;
    data['applied_for_vaccination'] = this._applied_for_vaccination;
    data['is_kyc'] = this._is_kyc;
    data['city'] = this._city;
    data['country'] = this._country;
    data['is_vaccinated'] = this._is_vaccinated;
    return data;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getEmail() {}
  
}

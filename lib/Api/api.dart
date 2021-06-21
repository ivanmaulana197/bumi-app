import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final _url = 'http://bumi-indo.herokuapp.com/api/v1/';

  postRegis({apiUrl, email, name, pass, passconfirm}) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl), body: {
      'email': email,
      'password': pass,
      'password_confirmation': passconfirm,
      'name': name
    });
  }

  postLogin({apiUrl, email, pass}) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl), body: {
      'email': email,
      'password': pass,
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Content {
  static var url = 'http://bumi-indo.herokuapp.com/api/v1/';

  static Future allContent() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'content'),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future countContent() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'content'),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['total'];
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future allCategory() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'category'),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future selectCategory(var id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'category/' + id),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future deadlineApproaching() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'deadline'),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future getDetailData(var id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'content/' + id.toString()),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future getSearch(var search) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.post(Uri.parse(url + 'search'),
        body: {'search': search},
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }
}

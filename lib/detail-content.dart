import 'dart:convert';
import 'package:coba_mod6/screen/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  String id;
  String title;
  DetailPage({Key key, this.id, this.title}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  SharedPreferences sp;
  var _urlimage = "http://bumi-indo.herokuapp.com/foto/content/";
  var url = 'http://bumi-indo.herokuapp.com/api/v1/';
  String title;

  Future getDetailData() async {
    sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    var response = await http.get(Uri.parse(url + 'content/' + widget.id),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getDetailData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                var body = snapshot.data['project'];
                return _detail(
                    title: body['title'],
                    gambar: body['gambar'],
                    deskripsi: body['deskripsi']);
              } else if (snapshot.hasError) {
                print("Has Error: ${snapshot.hasError}");
                return Text('Error!!!');
              } else {
                print("Loading...");
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _detail(
      {String gambar, String title, String category, String deskripsi}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //title
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff3A405A),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Center(
              child: Image.network(
            _urlimage + gambar,
            width: 300,
          )),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deskripsi:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

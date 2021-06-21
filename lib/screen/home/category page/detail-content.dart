import 'package:coba_mod6/models/content.dart';
import 'package:flutter/material.dart';

class DetailContentPage extends StatefulWidget {
  var id, title;
  DetailContentPage({this.id, this.title});
  @override
  _DetailContentPageState createState() => _DetailContentPageState();
}

class _DetailContentPageState extends State<DetailContentPage> {
  var _urlimage = "http://bumi-indo.herokuapp.com/foto/content/";
  Future getDetailContent;
  @override
  void initState() {
    super.initState();
    getDetailContent = Content.getDetailData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getDetailContent,
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
            color: Colors.green,
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

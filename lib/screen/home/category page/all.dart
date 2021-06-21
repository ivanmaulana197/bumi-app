import 'package:coba_mod6/models/content.dart';
import 'package:coba_mod6/screen/home/category%20page/widget-list-content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AllContent extends StatefulWidget {
  var title_content, category;
  AllContent({this.category, this.title_content});
  @override
  _AllContentState createState() => _AllContentState();
}

class _AllContentState extends State<AllContent> {
  Future getData;

  @override
  void initState() {
    getData = Content.allContent();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data['data'].length,
          itemBuilder: (context, index) {
            var data = snapshot.data['data'];
            return WidgetListContent(
              id: data[index]['id'],
              category: widget.category,
              gambar: data[index]['gambar'],
              title: data[index]['title'],
              tanggal_berakhir: data[index]['end_date'],
              vertikal: true,
            );
          },
        );
      },
    );
  }
}

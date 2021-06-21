import 'package:coba_mod6/models/content.dart';
import 'package:coba_mod6/screen/home/category%20page/content-page.dart';
import 'package:flutter/material.dart';

class ListContent extends StatefulWidget {
  Future apiContentan;
  var title_contentan;
  var category;
  ListContent({this.apiContentan, this.title_contentan, this.category});
  @override
  _ListContentState createState() => _ListContentState();
}

class _ListContentState extends State<ListContent> {
  Future content;
  var title;
  var category;
  @override
  void initState() {
    content = widget.apiContentan;
    Content.allCategory().then((value) {
      category = value['data'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3A405A),
        title: Text(widget.title_contentan),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  content = widget.apiContentan;
                });
              }),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ContentPage(
              apiContent: content,
              category: widget.category,
              title_content: widget.title_contentan,
              vertikalScrollDirection: true,
              all: true,
            ),
          ],
        ),
      ),
    );
  }
}

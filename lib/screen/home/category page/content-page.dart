import 'package:coba_mod6/screen/home/category%20page/list-content.dart';
import 'package:coba_mod6/screen/home/category%20page/widget-list-content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContentPage extends StatefulWidget {
  Future apiContent;
  var title_content, category;
  bool vertikalScrollDirection;
  bool all, home;
  ContentPage(
      {this.apiContent,
      this.title_content,
      this.category,
      this.vertikalScrollDirection,
      this.home,
      this.all});
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  Future getContent;
  var title_c;

  @override
  void initState() {
    super.initState();
    title_c = widget.title_content;
    getContent = widget.apiContent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.all == true && widget.home == true
                  ? SizedBox(height: 10)
                  : Text(
                      '${widget.title_content}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              widget.all == true
                  ? Container()
                  : FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ListContent(
                            apiContentan: getContent,
                            title_contentan: title_c,
                            category: widget.category,
                          );
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'view All ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ))
            ],
          ),
        ),
        SizedBox(
          height: widget.vertikalScrollDirection == true ? 500 : 250,
          child: FutureBuilder(
            future: getContent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data['data'];
                return ListView.builder(
                  scrollDirection: widget.vertikalScrollDirection == true
                      ? Axis.vertical
                      : Axis.horizontal,
                  itemCount: data.length > 0 ? data.length : 1,
                  itemBuilder: (context, index) {
                    if (data.length > 0) {
                      var nama_category;
                      for (int i = 0; i < widget.category.length; i++) {
                        if (data[index]['category_id'] ==
                            widget.category[i]['id']) {
                          nama_category = widget.category[i]['nama_category'];
                        }
                      }
                      return WidgetListContent(
                        id: data[index]['id'],
                        category: nama_category,
                        gambar: data[index]['gambar'],
                        title: data[index]['title'],
                        tanggal_berakhir: data[index]['end_date'],
                        vertikal: widget.vertikalScrollDirection == true
                            ? true
                            : false,
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text('Event Belum Ada')),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: Lottie.asset("assets/lottie/loading.json"),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

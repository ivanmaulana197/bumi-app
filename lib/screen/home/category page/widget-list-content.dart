import 'package:coba_mod6/screen/home/category%20page/detail-content.dart';
import 'package:flutter/material.dart';

class WidgetListContent extends StatefulWidget {
  var title, gambar, category, tanggal_berakhir, id;
  bool vertikal;
  WidgetListContent(
      {this.title,
      this.category,
      this.gambar,
      this.tanggal_berakhir,
      this.id,
      this.vertikal});

  @override
  _WidgetListContentState createState() => _WidgetListContentState();
}

class _WidgetListContentState extends State<WidgetListContent> {
  var _urlimage = "http://bumi-indo.herokuapp.com/foto/content/";
  Color getColor() {
    if (widget.category == 'Lomba') {
      return Colors.yellow[800];
    } else if (widget.category == 'Beasiswa') {
      return Colors.blue[900];
    } else if (widget.category == 'Seminar') {
      return Color(0xffE3170A);
    } else if (widget.category == 'Student Exchange') {
      return Colors.teal[400];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailContentPage(
              id: widget.id,
              title: widget.title,
            );
          }));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 325,
          decoration: BoxDecoration(
            color: Color(0xff7483A3),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
                offset: Offset(3, 3),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          //4056F4, 474056. 080357, 00AF54, 5F0A87,2F004F
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_urlimage + widget.gambar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Judul Event',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  Container(
                    width: widget.vertikal == true ? 190 : 120,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: getColor(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        widget.category,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Pendaftaran berakhir:',
                      style: TextStyle(fontSize: 11, color: Colors.white)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xffECFEE8),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          widget.tanggal_berakhir,
                          style: TextStyle(color: Colors.black),
                        )),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

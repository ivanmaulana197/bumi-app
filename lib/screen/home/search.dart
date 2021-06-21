import 'package:coba_mod6/models/content.dart';
import 'package:coba_mod6/screen/home/category%20page/widget-list-content.dart';
import 'package:coba_mod6/screen/home/home-page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  var category;
  SearchPage({this.category});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future getSearch;
  bool isLoading = false, input;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getSearch = Content.getSearch('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff7483A3),
          title: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff292639),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: searchController,
                onChanged: (value) {
                  if (value == '') {
                    setState(() {
                      input = false;
                    });
                  } else {
                    setState(() {
                      input = true;
                    });
                  }
                  setState(() {
                    getSearch = Content.getSearch(searchController.text);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Find Amazing Event...",
                  hintStyle: TextStyle(color: Color(0xff7483A3)),
                  border: InputBorder.none,
                  suffixIcon: input == true
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              input = false;
                            });
                          })
                      : IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: getSearch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (searchController.text == '') {
                return Center(
                  child: Text('Silahkan Input Data'),
                );
              } else {
                if (snapshot.data['project'] == null) {
                  return Center(
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: Lottie.asset("assets/lottie/loading.json"),
                    ),
                  );
                } else {
                  if (snapshot.data['project'].length > 0) {
                    var data = snapshot.data['project'];
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
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
                          vertikal: true,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Data Not Found'),
                    );
                  }
                }
              }
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
        ));
  }
}

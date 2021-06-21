import 'dart:convert';
import 'package:coba_mod6/models/content.dart';
import 'package:coba_mod6/screen/home/category%20page/content-page.dart';
import 'package:coba_mod6/screen/home/search.dart';
import 'package:coba_mod6/screen/login_regis/login-page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  SharedPreferences sp;
  TabController categoryTabController;
  var jumlah, username, content;
  Future category;

  setData() async {
    Content.allContent().then((value) {
      jumlah = value['total'];
    });
    content = await Content.allContent();
    sp = await SharedPreferences.getInstance();
    setState(() {
      jumlah = content['total'];
      username = sp.getString('username');
    });
  }

  @override
  void initState() {
    super.initState();
    category = Content.allCategory();
    setData();
    categoryTabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: category,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xffEDF1FA),
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      color: Color(0xff3A405A),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage("assets/img/img5.jpeg"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Hello ' +
                                        username.toString().toUpperCase() +
                                        ' !',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          category = Content.allCategory();
                                          Content.allContent().then((value) {
                                            jumlah = value['total'];
                                          });
                                        });
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        sp = await SharedPreferences
                                            .getInstance();
                                        sp.setBool('login', false);
                                        sp.remove('token');
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Welcome to BUMI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$jumlah Events around you",
                            style: TextStyle(
                              color: Color(0xffC3CCFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 6.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xff292639),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage(
                                              category: snapshot.data['data'],
                                            )));
                              },
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  hintText: "Find Amazing Event...",
                                  hintStyle:
                                      TextStyle(color: Color(0xff7483A3)),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: Color(0xff292639),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: TabBar(
                                isScrollable: true,
                                physics: BouncingScrollPhysics(),
                                controller: categoryTabController,
                                indicator: BoxDecoration(
                                  color: Color(0xff7483A3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                tabs: [
                                  Tab(
                                    text: 'All',
                                  ),
                                  Tab(
                                    text: 'Lomba',
                                  ),
                                  Tab(
                                    text: 'Beasiswa',
                                  ),
                                  Tab(
                                    text: 'Seminar',
                                  ),
                                  Tab(
                                    text: 'Student Exchange',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 320,
                    child: TabBarView(
                      controller: categoryTabController,
                      children: [
                        ContentPage(
                          apiContent: Content.allContent(),
                          category: snapshot.data['data'],
                          title_content: 'Event All',
                        ),
                        ContentPage(
                          apiContent: Content.selectCategory('1'),
                          category: snapshot.data['data'],
                          title_content: 'Lomba All',
                        ),
                        ContentPage(
                          apiContent: Content.selectCategory('2'),
                          category: snapshot.data['data'],
                          title_content: 'Beasiswa All',
                        ),
                        ContentPage(
                          apiContent: Content.selectCategory('3'),
                          category: snapshot.data['data'],
                          title_content: 'Student All',
                        ),
                        ContentPage(
                          apiContent: Content.selectCategory('4'),
                          category: snapshot.data['data'],
                          title_content: 'Student Exchange All',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ContentPage(
                    apiContent: Content.deadlineApproaching(),
                    category: snapshot.data['data'],
                    title_content: 'Deadline Approaching',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ContentPage(
                    apiContent: Content.allContent(),
                    category: snapshot.data['data'],
                    vertikalScrollDirection: true,
                    title_content: 'Event',
                    all: true,
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print("Has Error: ${snapshot.hasError}");
          return Text('Error!!!');
        } else {
          print("Loading...");
          return Center(
              child: SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset("assets/lottie/loading.json"),
          ));
        }
      },
    );
  }
}

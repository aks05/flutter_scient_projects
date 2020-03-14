import 'package:flutter/material.dart';
import 'package:flutterscrolltab/my_home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'carousel_button.dart';

void main() {
  runApp(new MaterialApp(
    home: new CardStack(),
  ));
}

class DynamicTabContent {
  String year;

  DynamicTabContent.name(this.year);
}

class CardStack extends StatefulWidget {
  @override
  _MainState createState() => new _MainState();
}

class _MainState extends State<CardStack> with TickerProviderStateMixin {
  final String baseUrl = "https://scient-api.herokuapp.com";
  final String url = "https://scient-api.herokuapp.com/api/projects/";

  List data;

  List<DynamicTabContent> myList = new List();
  List<Tab> myTabList= new List();

  @override
  void initState() {
    super.initState();
    this.getJsonData();

  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));
    print(response.body);

    setState(() {
      var jsonResponse = convert.jsonDecode(response.body);
      data = jsonResponse['results'];
      print(data);
      if(data!=null) {
        for(int i=0; i< data.length; i++) {
          int val= 2020-i;
          myList.add(DynamicTabContent.name(val.toString()));
          myTabList.add(Tab(text: val.toString(),));
          print(myTabList);
        }
      }
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    List <Widget> myButtonList = [
      CarouselButton(icon: Icons.image,name: "Gallery",onPressed: (){
        Navigator.pushNamed(context,'/gallery');
      },),
      CarouselButton(icon: Icons.assignment ,name: "Register",onPressed: (){
        Navigator.pushNamed(context,'/registration');
      },),
      CarouselButton(icon: Icons.work,name: "Projects",onPressed: (){
        Navigator.pushNamed(context,'/projects');
      },),
    ];
    return MaterialApp(
      home: DefaultTabController(
        length: data==null?0:data.length,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: myTabList.isEmpty
                  ?<Tab>[]
                  :myList.map((dynamicContent) {
                    return new Tab(text: dynamicContent.year,);
              }).toList(),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 600,
                  child:new TabBarView(
                    children:myList.isEmpty
                        ? <Widget>[]
                        : myList.map((dynamicContent) {
                      return new MyHomePage();
                    }).toList(),
                  ),
                ),
                CarouselSlider(
                  enlargeCenterPage: true,
                  autoPlay: false,
                  height: 70,
                  viewportFraction: 0.4,
                  items: myButtonList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.indigoAccent,
                            ),
                            child:i
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterscrolltab/project_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String baseUrl = "https://scient-api.herokuapp.com";
  final String url = "https://scient-api.herokuapp.com/api/projects/";

  List data;

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
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
          title: Text("PROJECTS PAGE!"),
        ),*/
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return ProjectCard(
              title: data[index]['title'],
              imagelink: data[index]['image_url'],
              description: data[index]['description'],);
          },
        ));
  }
}

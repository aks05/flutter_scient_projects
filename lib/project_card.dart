import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

class ProjectCard extends StatelessWidget {

  ProjectCard({@required this.description, @required this.imagelink, @required this.title});
  final String description;
  final String imagelink;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$title",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SlimyCard(
          topCardWidget: Image.network(imagelink),
          bottomCardWidget: Text("$description"),
        ),
        Container(
          width: 200,
          child: Divider(
            color: Colors.grey,
          ),

        ),
        SizedBox(
          height: 30,
        ),
      ],
    ) ;
  }
}

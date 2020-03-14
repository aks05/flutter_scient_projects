import 'package:flutter/material.dart';

class CarouselButton extends StatelessWidget {

  CarouselButton({@required this.icon, @required this.name, @required this.onPressed});

  final IconData icon;
  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon
            ),
            Text(
              '$name'
            )
          ],
        ),
      ),
    );
  }
}


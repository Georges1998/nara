import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  final Function event;
  final String text;

  const TopBarButton(
    this.event,
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        onPressed: this.event,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}

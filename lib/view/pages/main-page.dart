import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/main";
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '''Nara Lounge        
${DateTime.now().toString().substring(0, 10)} ''',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TopBarButton(() => print('Terrace'), 'Terrace'),
          TopBarButton(() => print('Delievery'), 'Delievery'),
          TopBarButton(() => print('UberEats'), 'UberEats'),
        ],
        backgroundColor: Colors.black87,
      ),
    );
  }
}

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

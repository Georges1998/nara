import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara/view/components/top-bar-buttons.component.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/main";
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

enum Status { firstPage, secondPage, terrace }

class _MainPageState extends State<MainPage> {
  Status page = Status.firstPage;
  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

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
            this.page == Status.terrace ? TopBarButton(
                () => setState(() {
                      this.page = Status.firstPage;
                    }),
                'Resto') :TopBarButton(
                () => setState(() {
                      this.page = Status.terrace;
                    }),
                'Terrace'),
            TopBarButton(() => print('Delievery'), 'Delievery'),
            TopBarButton(() => print('UberEats'), 'UberEats'),
          ],
          backgroundColor: Colors.black87,
        ),
        body: chooseWidget());
  }

  Widget chooseWidget() {
    switch (page) {
      case Status.secondPage:
        return Text("This is Second Page");
      case Status.terrace:
        return Text("This is Terrace");
      default:
        return Text("This is First Page");
    }
  }
}

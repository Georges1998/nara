import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara/models/table.dart';

class TablePage extends StatefulWidget {
  static String routeName = "/tablePage";

  TablePage({Key key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    final TableClass table = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            "Table " + table.id.toString(),
            style: TextStyle(color: Colors.white),
          )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.black54, Colors.black12],
              begin: const FractionalOffset(0.5, 0.0),
              end: const FractionalOffset(0.0, 0.9),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Text(table.id.toString()),
      ),
    );
  }
}

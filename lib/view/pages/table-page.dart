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
  String menueType = 'Sandwiches';
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i in [
                            "Sandwiches",
                            "Shisha",
                            "Desert",
                            "Meal",
                            "Drinks",
                            "Breakfast"
                          ])
                            FlatButton(
                              onPressed: () => {
                                setState(() {
                                  this.menueType = i;
                                  print(this.menueType);
                                })
                              },
                              child: Text(
                                i,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.60,
                //color: Color.fromRGBO(255, 155, 255, 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                width: MediaQuery.of(context).size.width * 0.35,
                // color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

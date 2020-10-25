import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara/models/addOns.dart';
import 'package:nara/models/contentOrderItem.dart';
import 'package:nara/models/menu.dart';
import 'package:nara/models/table.dart';
import 'package:nara/services/httpServices.dart';

class TablePage extends StatefulWidget {
  static String routeName = "/tablePage";

  TablePage({Key key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  Future<List<AddOns>> futurAddOns;
  Future<List<Menu>> futureMenu;
  String menueType = 'Sandwiches';
  List<ContentOrderItem> orderedItems = [];

  @override
  void initState() {
    super.initState();
    getMenu();
    futureMenu.then((value) => value.forEach((element) {
          print(element.itemName);
        }));
    futurAddOns = HttpServices.fetchAddOns();
    futurAddOns.then((value) => value.forEach((element) {
          print(element.id);
        }));
  }

  void getMenu() {
    setState(() {
      futureMenu = HttpServices.fetchMenu(type: menueType);
    });
  }

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
            buildMenu(context),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                width: MediaQuery.of(context).size.width * 0.35,
                child: Expanded(
                  child: ListView(shrinkWrap: true, children: [
                    for (var i in orderedItems)
                      Container(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(i.itemName),
                              Text(i.quantity.toString()),
                              IconButton(
                                icon: Icon(i.comment == null
                                    ? Icons.edit
                                    : Icons.comment),
                                color: Colors.deepPurpleAccent,
                                iconSize: 30,
                                onPressed: () => print(i),
                              )
                            ],
                          ))
                  ]),
                ),
                // color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildMenu(BuildContext context) {
    return Padding(
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
                          getMenu();
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
            ),
            FutureBuilder<List<Menu>>(
              future: futureMenu,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var i in snapshot.data)
                          Container(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(i.itemName),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.deepPurpleAccent,
                                    iconSize: 30,
                                    onPressed: () => addToOrderedList(i),
                                  )
                                ],
                              ))
                      ],
                    ),
                  );
                  // return Text(snapshot.data.first.itemName);
                } else if (snapshot.hasError) {
                  return Text("No Elmenets");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator(
                  strokeWidth: 8,
                  backgroundColor: Colors.purple,
                );
              },
            )
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.60,
        //color: Color.fromRGBO(255, 155, 255, 0.5),
      ),
    );
  }

  addToOrderedList(Menu i) {
    ContentOrderItem s =
        new ContentOrderItem(itemName: i.itemName, quantity: 1);
    bool exist = false;
    setState(() {
      orderedItems.forEach((element) {
        if (element.itemName == s.itemName) {
          element.quantity = element.quantity + 1;
          exist = true;
        }
      });
      if (!exist) {
        orderedItems.add(s);
      }
    });
  }
}

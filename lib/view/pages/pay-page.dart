import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nara/models/addOns.dart';
import 'package:nara/models/contentOrderItem.dart';
import 'package:nara/models/menu.dart';
import 'package:nara/models/order.dart';
import 'package:nara/models/table.dart';
import 'package:nara/services/httpServices.dart';

class PayPage extends StatefulWidget {
  static String routeName = "/payPage";

  PayPage({Key key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  Future<List<AddOns>> futurAddOns;
  Future<List<Menu>> futureMenu;
  String menueType = 'Sandwiches';
  List<ContentOrderItem> orderedItems = [];
  final _formKey = GlobalKey<FormState>();
  TableClass table = null;
  final commentController = TextEditingController();

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
    this.table = table;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Text("Done",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                onTap: () => sendOrder(),
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            "Bill for Table " + table.id.toString(),
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
            // buildMenu(context),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.5)),
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "Ordered Items",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Colors.white,
                      height: 60,
                      width: double.infinity,
                    ),
                    Expanded(
                      child: ListView(shrinkWrap: true, children: [
                        for (var i in orderedItems)
                          Container(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    i.itemName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    i.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    color: Colors.deepPurpleAccent,
                                    iconSize: 30,
                                    onPressed: () => removeOrder(i),
                                  ),
                                  IconButton(
                                    icon: Icon(i.comment == null
                                        ? Icons.edit
                                        : Icons.comment),
                                    color: Colors.deepPurpleAccent,
                                    iconSize: 30,
                                    onPressed: () => addComment(i),
                                  ),
                                ],
                              ))
                      ]),
                    ),
                  ],
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
              child: ListView(
                scrollDirection: Axis.horizontal,
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
                      children: [for (var i in snapshot.data) buildMenuItem(i)],
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

  Container buildMenuItem(Menu i) {
    return Container(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 140,
              child: Text(
                i.itemName,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              width: 150,
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Text(
                'Price: ' + i.price.toString(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.deepPurpleAccent,
              iconSize: 30,
              onPressed: () => addToOrderedList(i),
            )
          ],
        ));
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

  addComment(ContentOrderItem i) {
    if (i.comment != null) {
      setState(() {
        this.commentController.text = i.comment;
      });
    }
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              actions: [
                FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    sendRequest();
                  },
                ),
              ],
              title: Text("Comments"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    maxLines: 1,
                    controller: commentController,
                  ),
                ],
              ));
        }).then((value) => {
          if (commentController.text != '')
            {
              setState(() {
                this.orderedItems.forEach((element) {
                  if (element.itemName == i.itemName) {
                    element.comment = commentController.text;
                  }
                });
              }),
              commentController.text = "",
            }
        });
  }

  addAddOns(ContentOrderItem i) {}

  removeOrder(ContentOrderItem i) {
    List<ContentOrderItem> newOrder = [];
    this.orderedItems.forEach((element) {
      newOrder.add(element);
    });
    newOrder.remove(i);
    setState(() {
      this.orderedItems.forEach((element) {
        if (element.itemName == i.itemName) {
          element.quantity -= 1;
          if (element.quantity < 1) {
            this.orderedItems = newOrder;
          }
        }
      });
    });
  }

  sendOrder() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Send Order?"),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  sendRequest();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void sendRequest() {
    var order = new Order(
        comment: '',
        owner: 'George',
        table: this.table.id,
        orderItems: this.orderedItems);
    HttpServices.sendOrder(order);
    print(order.toString());
  }
}

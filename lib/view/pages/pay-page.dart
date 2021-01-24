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
  Future<List<ContentOrderItem>> futureOrders;

  String menueType = 'Sandwiches';
  List<ContentOrderItem> orderedItems = [];
  final _formKey = GlobalKey<FormState>();
  TableClass table = null;
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMenu();

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
    getOrders(table.key);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                child: Text("Pay",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                onTap: () => payOrder(table.key),
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
            buildOrderList(context),
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
                          "Pay",
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

  Padding buildOrderList(BuildContext context) {
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
              child: Center(
                child: Text(
                  "Ordered Items ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            FutureBuilder<List<ContentOrderItem>>(
              future: futureOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var i in snapshot.data) buildOrderItem(i)
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

  void getOrders(String tableKey) {
    setState(() {
      futureOrders = HttpServices.fetchOrder(tableKey);
    });
  }

  Container buildOrderItem(ContentOrderItem i) {
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
              width: 20,
              child: Text(
                i.quantity.toString(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              width: 150,
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Text(
                'Paid: ' + i.paid.toString(),
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

  addToOrderedList(ContentOrderItem i) {
    ContentOrderItem s =
        new ContentOrderItem(itemName: i.itemName, quantity: 1);
    bool exist = false;
    setState(() {
      orderedItems.forEach((element) {
        if (element.itemName == s.itemName) {
          if (element.quantity < i.quantity) {
            element.quantity = element.quantity + 1;
          }
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

  payOrder(String key) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pay?"),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  sendRequest();
                  // getOrders(key);
                  setState(() {
                    this.orderedItems = [];
                  });
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

//TODO: send request
  void sendRequest() {
    print(this.table.key);
    HttpServices.payOrder(this.orderedItems, this.table.key)
        .then((value) => getOrders(this.table.key));
  }
}

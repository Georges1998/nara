import 'package:flutter/material.dart';
import 'package:nara/models/table.dart';
import 'package:nara/view/pages/pay-page.dart';
import 'package:nara/view/pages/table-page.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    Key key,
    @required this.table,
  }) : super(key: key);

  final TableClass table;

  @override
  Widget build(BuildContext context) {
    showOptions() {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title:
                  Text("What do you want to do with table? " + this.table.key),
              actions: [
                FlatButton(
                  child: Text('New Order'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, TablePage.routeName,
                        arguments: table);
                    // Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Pay Order'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, PayPage.routeName,
                        arguments: table);
                  },
                ),
              ],
            );
          });
    }

    return GestureDetector(
      onTap: () {
        showOptions();
        // Navigator.pushNamed(context, TablePage.routeName, arguments: table);
      },
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            table.id.toString(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            color: table.type == 'terrace'
                ? Colors.teal
                : table.type == 'uber'
                    ? Colors.lightGreen
                    : table.type == 'delievery'
                        ? Colors.indigo[400]
                        : Colors.black87),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nara/models/table.dart';
import 'package:nara/view/pages/table-page.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    Key key,
    @required this.table,
  }) : super(key: key);

  final TableClass table;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TablePage.routeName, arguments: table);
      },
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            'Table ' + table.id.toString(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            color: table.occupied ? Colors.deepPurple : Colors.black87),
      ),
    );
  }
}

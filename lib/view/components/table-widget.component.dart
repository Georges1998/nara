import 'package:flutter/material.dart';
import 'package:nara/models/table.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    Key key,
    @required this.table,
  }) : super(key: key);

  final TableClass table;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
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
    );
  }
}

import 'dart:convert';

import 'package:nara/models/contentOrderItem.dart';

class Order {
  String table;
  List<ContentOrderItem> orderItems = [];
  String comment;
  String owner;
  DateTime date;

  Order({this.table, this.date, this.owner, this.orderItems, this.comment});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      table: json['table'],
      orderItems: json['orderItems'],
      comment: json['comment'],
      owner: json['owner'],
    );
  }
  Map<String, dynamic> toJson() => {
        'table': table,
        'orderItems': jsonEncode(orderItems),
        'comment': comment,
        'owner': owner,
        'date': date.toString(),
      };
}

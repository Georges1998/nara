import 'package:nara/models/contentOrderItem.dart';

class Order {
  String table;
  List<ContentOrderItem> orderItems = [];
  String comment;
  String owner;

  Order({this.table, this.owner, this.orderItems, this.comment});

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
        'orderItems': orderItems.map((e) => e.toJson()).toList(),
        'comment': comment == null ? "" : comment,
        'owner': owner,
      };
}

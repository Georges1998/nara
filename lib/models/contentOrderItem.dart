import 'package:nara/models/addOns.dart';

class ContentOrderItem {
  int quantity;
  List<AddOns> addOns = [];
  String comment;
  String itemName;

  ContentOrderItem({this.itemName, this.quantity, this.addOns, this.comment});

  factory ContentOrderItem.fromJson(Map<String, dynamic> json) {
    return ContentOrderItem(
      quantity: json['quantity'],
      addOns: json['addOns'],
      comment: json['comment'],
      itemName: json['itemName'],
    );
  }
}

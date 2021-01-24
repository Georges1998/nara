class ContentOrderItem {
  int quantity;
  dynamic addOns;
  String comment;
  String itemName;
  int paid = 0;

  ContentOrderItem(
      {this.itemName, this.quantity, this.addOns, this.comment, this.paid=0});

  factory ContentOrderItem.fromJson(Map<String, dynamic> json) {
    return ContentOrderItem(
        quantity: json['quantity'],
        addOns: json['addOns'],
        comment: json['comment'],
        itemName: json['itemName'],
        paid: json['paid']);
  }
  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'addOns': addOns != null ? addOns.map((e) => e.toJson()).toList() : [],
        'comment': comment == null ? null : comment,
        'itemName': itemName,
        'paid': paid,
      };
}

class AddOns {
  int id;
  int price;
  int quantity;
  String itemName;

  AddOns({this.id, this.price, this.quantity, this.itemName});

  factory AddOns.fromJson(Map<String, dynamic> json) {
    return AddOns(
      id: json['id'],
      price: json['price'],
      quantity: json['quantity'],
      itemName: json['itemName'],
    );
  }

   Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'price': price.toString(),
        'quantity': quantity.toString(),
        'itemName': itemName,
      };
}

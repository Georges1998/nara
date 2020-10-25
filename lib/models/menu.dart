class Menu {
  int id;
  int price;
  String itemName;
  String type;

  Menu({this.id, this.price, this.itemName, this.type});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      price: json['price'],
      itemName: json['itemName'],
      type: json['type'],
    );
  }
}

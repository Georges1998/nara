import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nara/models/addOns.dart';
import 'package:nara/models/menu.dart';
import 'package:nara/models/order.dart';

class HttpServices {
  static Future<List<AddOns>> fetchAddOns() async {
    List<AddOns> addOns = [];

    final response = await http.get(
      'https://naraapi.azurewebsites.net/AddOnMenu',
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      body.forEach((e) => {addOns.add(AddOns.fromJson(e))});
      return addOns;
    } else {
      throw Exception('Failed to load addOns');
    }
  }

  static Future<List<Menu>> fetchMenu({String type}) async {
    List<Menu> menu = [];
    String endpoint = 'https://naraapi.azurewebsites.net/Menu';
    if (type != null) {
      endpoint = endpoint + '?Types=' + type;
    }

    final response = await http.get(
      endpoint,
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      body.forEach((e) => {menu.add(Menu.fromJson(e))});
      return menu;
    } else {
      throw Exception('Failed to load addOns');
    }
  }

  static Future<Order> sendOrder(Order order) async {
    String json = jsonEncode(order);
    final http.Response response = await http.post(
      'https://naraapi.azurewebsites.net/Order',
      body: json,
    );
    print(json);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    //   return Order.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to create Order');
    // }
  }
}

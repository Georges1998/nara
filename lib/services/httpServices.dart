import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nara/models/addOns.dart';
import 'package:nara/models/menu.dart';
import 'package:nara/models/order.dart';

class HttpServices {
  static final String url = "https://eliassco.azurewebsites.net/";

  static Future<List<AddOns>> fetchAddOns() async {
    List<AddOns> addOns = [];

    final response = await http.get(url + 'AddOnMenu');

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
    String endpoint = url + 'Menu';
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

  static Future<String> sendOrder(Order order) async {
    String json = jsonEncode(order);
    final http.Response response = await http.post(
      url + 'Order',
      body: json,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    return json;
  }
}

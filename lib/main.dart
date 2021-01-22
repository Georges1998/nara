import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nara/view/pages/main-page.dart';
import 'package:nara/view/pages/pay-page.dart';
import 'package:nara/view/pages/table-page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: "Muli",
            primaryColor: Color(0xffffffff),
            accentColor: Color(0xff4AA35B),
            iconTheme: IconThemeData(color: Color.fromRGBO(84, 84, 84, 1))),
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => MainPage(),
          TablePage.routeName: (context) => TablePage(),
          PayPage.routeName: (context) => PayPage(),
        },
        title: 'Nara');
  }
}

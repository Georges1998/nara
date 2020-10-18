import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara/view/components/table-widget.component.dart';
import 'package:nara/view/components/top-bar-buttons.component.dart';
import 'package:nara/models/table.dart';

class MainPage extends StatefulWidget {
  static String routeName = "/main";
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

enum Status { firstPage, secondPage, terrace }

class _MainPageState extends State<MainPage> {
  Status page = Status.firstPage;
  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '''Nara Lounge        
${DateTime.now().toString().substring(0, 10)} ''',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            this.page == Status.terrace
                ? TopBarButton(
                    () => setState(() {
                          this.page = Status.firstPage;
                        }),
                    'Resto')
                : TopBarButton(
                    () => setState(() {
                          this.page = Status.terrace;
                        }),
                    'Terrace'),
            TopBarButton(() => print('Delievery'), 'Delievery'),
            TopBarButton(() => print('UberEats'), 'UberEats'),
          ],
          backgroundColor: Colors.black87,
        ),
        body: Container(
          child: chooseWidget(),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.black54, Colors.black12],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.9),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ));
  }

  Widget buildFristPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10.0),
          width: 800,
          child: GridView.count(
            crossAxisCount: 5,
            children: List.generate(15, (index) {
              return TableWidget(
                  table: new TableClass(
                      id: index + 1, occupied: (index + 1) % 3 == 0));
            }),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () {
              setState(() {
                this.page = Status.secondPage;
              });
            },
            icon: Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.black87),
        ),
      ],
    );
  }

  Widget buildSecondPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () {
              setState(() {
                this.page = Status.firstPage;
              });
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10.0),
          width: 800,
          child: GridView.count(
            crossAxisCount: 5,
            children: List.generate(15, (index) {
              return TableWidget(
                  table: new TableClass(
                      id: index + 16, occupied: (index + 1) % 4 == 0));
            }),
          ),
        )
      ],
    );
  }

  Widget chooseWidget() {
    switch (page) {
      case Status.secondPage:
        return buildSecondPage();
      case Status.terrace:
        return Text("This is Terrace");
      default:
        return buildFristPage();
    }
  }
}

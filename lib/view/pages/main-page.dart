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

enum Status { firstPage, secondPage, terrace, delivery, uber }

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
          title: GestureDetector(
            onTap: () => setState(() {
              this.page = Status.firstPage;
            }),
            child: Text(
              '''Nara Lounge        
${DateTime.now().toString().substring(0, 10)} ''',
              style: TextStyle(color: Colors.white),
            ),
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
            TopBarButton(
                () => setState(() {
                      this.page = Status.delivery;
                    }),
                'Delievery'),
            TopBarButton(
                () => setState(() {
                      this.page = Status.uber;
                    }),
                'UberEats'),
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
                      id: "T" + (index + 1).toString(),
                      key: "T" + (index + 1).toString(),
                      type: 'inside'));
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

  Widget buildTerrace() {
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
                      id: "S" + (index + 1).toString(),
                      key: "S" + (index + 1).toString(),
                      type: 'terrace'));
            }),
          ),
        ),
      ],
    );
  }

  Widget buildUber() {
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
                      id: "U" + (index + 1).toString(),
                      key: "U" + (index + 1).toString(),
                      type: 'uber'));
            }),
          ),
        ),
      ],
    );
  }

  Widget buildDelievery() {
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
                      id: "D" + (index + 1).toString(),
                      key: "D" + (index + 1).toString(),
                      type: 'delievery'));
            }),
          ),
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
                      id: "T" + (index + 16).toString(),
                      key: "T" + (index + 16).toString(),
                      type: 'inside'));
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
        return buildTerrace();
      case Status.delivery:
        return buildDelievery();
      case Status.uber:
        return buildUber();
      default:
        return buildFristPage();
    }
  }
}

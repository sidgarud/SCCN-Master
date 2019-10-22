import 'package:flutter/material.dart';
import 'donut.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
  //print(cool.month);
}

var pg1data;
var pg2data;
//NewScopeStructure cool;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(
        'assets/finallyfinal.flr',
        HomePage(),
        startAnimation: 'Untitled',
        //endAnimation: 'Untitled',
        //loopAnimation: 'Untitled',
        until: () => Future.delayed(const Duration(seconds: 5), () async {
          http.Response response;
          do {
            response = await http
                .get("https://www.creationdevs.in/sccn/fetchmain.php");
          } while (response.statusCode != 200);
          pg1data = response.body.toString();
          pg1data = removeAllHtmlTags(pg1data[0]);
          //debugPrint(pg1data);
          //pg1data = json.decode(pg1data[0]);
          do {
            response =
                await http.get("https://www.creationdevs.in/sccn/fetch.php");
          } while (response.statusCode != 200);
          pg2data = response.body.toString();
          pg2data = removeAllHtmlTags(pg2data);
          //debugPrint(pg2data);
          //pg2data = json.decode(pg2data[0]);
          //cool = NewScopeStructure.fromJson(pg1data, "Scope1", 0);
          //debugPrint(cool.month.toString());
          //setState(() {
          //  userData = data["data"];
          //});
          //debugPrint(data.toString());
        }),
        backgroundColor: Color(0xffC1FBCE),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

//Chart Class:
class scopeStructure {
  final DateTime month;
  final double emissionValue;

  scopeStructure({this.month, this.emissionValue});
}

//Variables:
var lineDataScope1 = [
  scopeStructure(month: DateTime(2019, 3), emissionValue: 40),
  scopeStructure(month: DateTime(2019, 4), emissionValue: 20),
  scopeStructure(month: DateTime(2019, 5), emissionValue: 50),
  scopeStructure(month: DateTime(2019, 6), emissionValue: 60),
  scopeStructure(month: DateTime(2019, 7), emissionValue: 25),
  scopeStructure(month: DateTime(2019, 8), emissionValue: 35),
];

var lineDataScope2 = [
  scopeStructure(month: DateTime(2019, 3), emissionValue: 50),
  scopeStructure(month: DateTime(2019, 4), emissionValue: 70),
  scopeStructure(month: DateTime(2019, 5), emissionValue: 20),
  scopeStructure(month: DateTime(2019, 6), emissionValue: 60),
  scopeStructure(month: DateTime(2019, 7), emissionValue: 15),
  scopeStructure(month: DateTime(2019, 8), emissionValue: 75),
];

var lineDataScope3 = [
  scopeStructure(month: DateTime(2019, 3), emissionValue: 55),
  scopeStructure(month: DateTime(2019, 4), emissionValue: 27),
  scopeStructure(month: DateTime(2019, 5), emissionValue: 25),
  scopeStructure(month: DateTime(2019, 6), emissionValue: 97),
  scopeStructure(month: DateTime(2019, 7), emissionValue: 23),
  scopeStructure(month: DateTime(2019, 8), emissionValue: 34),
];

//Line Series:
var lineSeries = [
  charts.Series(
    domainFn: (scopeStructure s, _) => s.month,
    measureFn: (scopeStructure s, _) => s.emissionValue,
    id: "Scope 1",
    data: lineDataScope1,
  ),
  charts.Series(
    domainFn: (scopeStructure s, _) => s.month,
    measureFn: (scopeStructure s, _) => s.emissionValue,
    id: "Scope 2",
    data: lineDataScope2,
  ),
  charts.Series(
    domainFn: (scopeStructure s, _) => s.month,
    measureFn: (scopeStructure s, _) => s.emissionValue,
    id: "Scope 3",
    data: lineDataScope3,
  ),
];

//Chart Design
var lineChart = charts.TimeSeriesChart(
  lineSeries,
  animate: true,
  behaviors: [charts.SeriesLegend(desiredMaxColumns: 1)],
);

//Chart Builder
var lineChartWidget = Padding(
  padding: EdgeInsets.all(24.0),
  child: Card(
    child: SizedBox(
      height: 300.0,
      child: lineChart,
    ),
  ),
);

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Container(
      //Code for dashboard begins here
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFFC1FBCE),
          const Color(0xFFA5D6A7),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          //Insert dashboard Code here
          Container(
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                width: 2,
              ),
            ),
            child: Center(
                child: Text('Scope Wise Distribution',
                    style: TextStyle(color: Colors.black, fontSize: 24))),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 280,
                        height: 280,
                        child: DonutAutoLabelChart.withSampleData(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: Center(
                            child: Text('Worst Performer: Scope 2',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20))),
                      ),
                      Container(
                        child: lineChartWidget,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    WebviewScaffold(
        initialChild: Container(
          color: Colors.white,
          child: Center(
            child: Text('Visualing Data..'),
          ),
        ),
        hidden: true,
        url: 'http://creationdevs.in/sccn/webview.php'),
//    Container(
//      //Code for graphs begins here
//      decoration: BoxDecoration(
//        gradient: LinearGradient(colors: [
//          const Color(0xFFC1FBCE),
//          const Color(0xFF69F0AE),
//        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//      ),
//      child: ListView(
//        padding: EdgeInsets.all(10.0),
//        children: <Widget>[
//          //Insert Graph Code here
//          Container(
//            width: 200,
//            height: 250,
//          )
//        ],
//      ),
//    ),
    Container(
      //Code for legend begins here
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFFC1FBCE),
          const Color(0xFFA5D6A7),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white70,
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Scope 1',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Direct Green House Gas Emissions',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Image.asset(
                    'assets/newScope1.PNG',
                    width: 240,
                    height: 240,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Direct GHG emissions occur from sources that are owned or controlled by the institution, for example, emissions from cooking gas, combustion in owned or controlled boilers, vehicles, etc.; emissions from chemical, pharmaceutical labs.",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white30,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Scope 2',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Electricity Greenhouse Gas Emissions',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Image.asset(
                      'assets/newScope2.PNG',
                      width: 240,
                      height: 240,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "This scope accounts for GHG emissions from the generation of purchased electricity consumed by a institution. Purchased electricity is defined as electricity that is purchased or otherwise brought into the organizational boundary of the Institute. These emissions physically occur at the facility where electricity is generated.",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white30,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Scope 3',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Other Indirect Greenhouse Gas Emissions',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Image.asset(
                      'assets/newScope3.PNG',
                      width: 240,
                      height: 240,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "This is an optional reporting category that allows for the treatment of all other indirect emissions. These emissions are a consequence of the activities of the Institute, but occur from sources not owned or controlled by the Institute. Some examples of scope 3 activities are extraction and production of purchased materials; transportation of purchased fuels; and use of products and services.",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Image.asset(
            'assets/sccn_logo.png',
            fit: BoxFit.cover,
            color: Colors.white,
          ),
        ),
        title: Text('Smart Campus Cloud Network'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
              color: Colors.white,
            ),
            title: Text(
              'Graphs',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
            title: Text(
              'Legend',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    ));
  }
}

//Test SafeArea
class NewScopeStructure {
  final DateTime month;
  final double emissionValue;
  final String scopeName;

  NewScopeStructure({this.scopeName, this.month, this.emissionValue});

  factory NewScopeStructure.fromJson(
      Map<String, dynamic> json, String scope, int id) {
    return NewScopeStructure(
      scopeName: json[scope],
      month: json[scope][id]['month'],
      emissionValue: json[scope][id]['emission'],
    );
  }
}

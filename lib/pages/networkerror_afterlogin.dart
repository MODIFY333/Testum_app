import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testum/pages/home.dart';
import 'package:testum/ui/widgets/common_scaffold.dart';

class NoNetwork extends StatefulWidget {
  final String name;

  NoNetwork({Key key, this.name}) : super(key: key);

  @override
  NoNetworkState createState() => NoNetworkState();
}

class NoNetworkState extends State<NoNetwork> {
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new QuizHome());
        Navigator.of(context).push(router);
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  Future<String> getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new QuizHome());
        Navigator.of(context).push(router);
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    return null;
  }

  Widget bodyData() {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: defaultTargetPlatform == TargetPlatform.android ? 0.0 : 0.0,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Testum"),
        centerTitle: true,
        automaticallyImplyLeading: false,
//        actions: <Widget>[
//      IconButton(
//        icon: Icon(Icons.list),
//        onPressed: () {},
//      )
//        ],
      ),
      body: RefreshIndicator(
        key: formKey,
        // child:  Scaffold(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Center(
            child: new ListView(
              children: <Widget>[
                new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Проверьте сетевое соединение",
                        style: new TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
        onRefresh: refreshList,
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    getData();
  }

  Widget _scaffold() => CommonScaffold(
        scaffoldKey: scaffoldKey,
        bodyData: bodyData(),
        floatBtn: false,
      );

  @override
  Widget build(BuildContext context) {
    return _scaffold();

    // return
  }
}

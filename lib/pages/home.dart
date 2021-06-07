import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testum/apidata/apidata.dart';
import 'package:testum/global.dart';
import 'package:testum/main.dart';
import 'package:testum/pages/networkerror_afterlogin.dart';
import 'package:testum/pages/perticular_quiz_detail.dart';
import 'package:testum/ui/widgets/CustomShowDialog.dart';
import 'package:testum/ui/widgets/common_scaffold.dart';

var finalScore = 0;
var questionNumber = 0;
var test;
List qData;
List topicsData;
num mark;

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Testum',
    color: Color.fromRGBO(62, 130, 148, 1),
  ));
}

class QuizHome extends StatefulWidget {
  QuizHome({Key key, this.name, this.email, this.nameInitial})
      : super(key: key);
  final String name;
  final String email;
  final String nameInitial;
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<String> getData() async {
    try {
      final response =
          await http.get(Uri.encodeFull(APIData.quizCatApi), headers: {
        HttpHeaders.AUTHORIZATION: fullData // ignore: deprecated_member_use
      });

      var dbData = json.decode(response.body);
      this.setState(() {
        topicsData = dbData['topics'];
        qData = dbData['questions'];
      });
    } on SocketException catch (_) {
      var router = new MaterialPageRoute(
          builder: (BuildContext context) => new NoNetwork());
      Navigator.of(context).push(router);
      print('not connected');
    }
    return null;
  }

  @override
  void initState() {
    this.getData();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });

    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      } else {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new NoNetwork());
        Navigator.of(context).push(router);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget bodyData() {
    if (topicsData == null) {
      return new Container(
        child: RefreshIndicator(
          key: refreshKey,
          child: new WillPopScope(
            onWillPop: () async {
              return showDialog(
                    context: context,
                    builder: (context) => new CustomAlertDialog(
                      title: new Text(
                        'Вы уверены?',
                        textAlign: TextAlign.center,
                      ),
                      content: new Container(
                        width: 260.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xFFFFFF),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(30.0)),
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Text('Вы хотите выйти'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: new Text('Нет'),
                        ),
                        new FlatButton(
                          onPressed: () => exit(0),
                          child: new Text('Да'),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                final makeListTile = ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(Icons.play_circle_outline, color: Colors.white),
                  ),
                  title: Text(
                    "Данные не доступны",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale, color: Colors.yellowAccent),
                      Text("Темы не доступны",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.white, size: 30.0),
                  onTap: () {},
                );
                final makeCard = Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child: makeListTile,
                  ),
                );
                return makeCard;
              },
            ),
          ),
          onRefresh: refreshList,
        ),
      );
    } else {
      return new Container(
        child: RefreshIndicator(
          key: refreshKey,
          child: new WillPopScope(
            onWillPop: () async {
              return showDialog(
                    context: context,
                    builder: (context) => new CustomAlertDialog(
                      title: new Text(
                        'Вы уверены?',
                        textAlign: TextAlign.center,
                      ),
                      content: new Container(
                        width: 260.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xFFFFFF),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(30.0)),
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Text('Вы хотите выйти'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: new Text('Нет'),
                        ),
                        new FlatButton(
                          onPressed: () => exit(0),
                          child: new Text('Да'),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: topicsData == null ? 0 : topicsData.length,
              itemBuilder: (BuildContext context, int index) {
                final makeListTile = ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(Icons.play_circle_outline, color: Colors.white),
                  ),
                  title: Text(
                    "${topicsData[index]['title']}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale, color: Colors.yellowAccent),
                      Text(
                          " Время прохождения: ${topicsData[index]['timer'] == null ? "N/A" : "${topicsData[index]['timer']} min"} ",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.white, size: 30.0),
                  onTap: () {
//                    var m=json.decode(topicsData[index]['timer']) as int;
                    var m = topicsData[index]['timer'];

                    var router = new MaterialPageRoute(
                        builder: (BuildContext context) => new QuickQuiz(
                              id: topicsData[index]['id'],
                              title: "${topicsData[index]['title']}",
                              description:
                                  "Описание теста: ${topicsData[index]['description']}",
                              perQMark:
                                  "Баллы за вопрос: ${topicsData[index]['per_q_mark']}",
//                          marks:json.decode(topicsData[index]['per_q_mark']) as num,
                              marks: topicsData[index]['per_q_mark'],
                              timer:
                                  " Время теста: ${topicsData[index]['timer'] == null ? "N/A" : "${topicsData[index]['timer']} min"} ",
                              time: m,
                            ));
                    Navigator.of(context).push(router);
                  },
                );
                final makeCard = Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    child: makeListTile,
                  ),
                );
                return makeCard;
              },
            ),
          ),
          onRefresh: refreshList,
        ),
      );
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 2));
    getData();
  }

  Widget _scaffold() => CommonScaffold(
        bodyData: bodyData(),
        floatBtn: false,
        quizAppBar: true,
        showDrawer: true,
        backGroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      );

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  void deleteFile() {
    print("Deleting file!");
    File file = new File(dir.path + "/" + fileName);
    file.delete();
    setState(() {
      fileExists = false;
    });
    var router =
        new MaterialPageRoute(builder: (BuildContext context) => new Home());
    Navigator.of(context).push(router);
  }
}

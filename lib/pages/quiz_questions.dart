import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:testum/apidata/apidata.dart';
import 'package:testum/global.dart';
import 'package:connectivity/connectivity.dart';
import 'package:testum/pages/home.dart';
import 'package:testum/pages/networkerror_afterlogin.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Testum',
    home: QuizQuestion(),
    color: Colors.blue[900],
  ));
}

var finalScore = 0;
var questionNumber = 0;
var dbData;
List topicsData;
List qData;

class QuizQuestion extends StatefulWidget {
  QuizQuestion(
      {Key key,
      this.id,
      this.timer,
      this.catQues,
      this.perQMark,
      this.qCount,
      this.totalM})
      : super(key: key);
  final id;
  final timer;
  final catQues;
  final perQMark;
  final qCount;
  final totalM;

  @override
  QuizQuestionState createState() => QuizQuestionState();
}

class QuizQuestionState extends State<QuizQuestion>
    with TickerProviderStateMixin {
  bool _isButtonDisabled;

  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  AnimationController controller;
  Timer pageController;

  String get timer {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  //static const int kStartValue = 20;
  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text("Testum"),
    centerTitle: true,
  );

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();

    controller = new AnimationController(
      vsync: this,
      duration: new Duration(
        minutes: widget.timer.toInt(),
      ),
    );
    pageController = new Timer(Duration(minutes: widget.timer.toInt()), () {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new Summary2(
                  perQMark: widget.perQMark,
                  qCount: widget.qCount,
                  totalM: widget.totalM,
                  score: finalScore)));
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

  void aftersubmitA() {
    setState(() {
      _isButtonDisabled = true;
      AnsSubmitA();
    });
  }

  void aftersubmitB() {
    setState(() {
      _isButtonDisabled = true;
      AnsSubmitA();
    });
  }

  void aftersubmitC() {
    setState(() {
      _isButtonDisabled = true;
      AnsSubmitA();
    });
  }

  void aftersubmitD() {
    setState(() {
      _isButtonDisabled = true;
      AnsSubmitA();
    });
  }

  Widget AnsSubmitA() {
    if ("A" == "${widget.catQues[questionNumber]['answer']}") {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "A",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          finalScore = (finalScore) + (widget.perQMark);
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Correct");
    } else {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "A",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Wrong");
    }
  }

  Widget AnsSubmitB() {
    if ("B" == "${widget.catQues[questionNumber]['answer']}") {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "B",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          finalScore = (finalScore) + (int.parse(widget.perQMark));
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Correct");
    } else {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "B",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Wrong");
    }
  }

  Widget AnsSubmitC() {
    if ("C" == "${widget.catQues[questionNumber]['answer']}") {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "C",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          finalScore = (finalScore) + (int.parse(widget.perQMark));
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Correct");
    } else {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "C",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Wrong");
    }
  }

  Widget AnsSubmitD() {
    if ("D" == "${widget.catQues[questionNumber]['answer']}") {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "D",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          finalScore = (finalScore) + (int.parse(widget.perQMark));
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Correct");
    } else {
      Future<String> _login() async {
        try {
          var url = APIData.submitQuestionApi;
          // ignore: deprecated_member_use
          var ans = await http.post(url, headers: {
            HttpHeaders.AUTHORIZATION: fullData
          }, body: {
            "question_id": "${widget.catQues[questionNumber]['id']}",
            "user_answer": "D",
            "answer": "${widget.catQues[questionNumber]['answer']}",
          });
          updateQuestion();
          return (ans.body);
        } on SocketException catch (_) {
          Navigator.pop(context);
          Navigator.pop(context);
          print('not connected');
          return null;
        }
      }

      _login();
      debugPrint("Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    void playYoutubeVideoEdit() {
      var youtube = new FlutterYoutube();

//      youtube.onVideoEnded.listen((onData) {
//        //perform your action when video playing is done
//      });

      FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: APIData.youtubeApi,
          videoUrl: "${widget.catQues[questionNumber]['question_video_link']}",
          autoPlay: true,
          fullScreen: true);
    }

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);

    var image = APIData.questionImage +
        "${widget.catQues[questionNumber]['question_img']}";
    var video = "${widget.catQues[questionNumber]['question_video_link']}";

// If you don't want to include expression in the name of image
    //var imageNameWithExp = "${widget.catQues[questionNumber]['question_img']}";
    //    String imageName = imageNameWithExp.replaceAll(new RegExp(r"/^\s+|\s+\(|\)|\_|\s+\b|\b\s"),"");
    //    print(imageName);

    print(image);
    if (image == APIData.questionImage + "null") {
      if (video == "null") {
        return new Scaffold(
          body: new WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                body: new Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text(
                                "Осталось",
                                // style: themeData.textTheme.subhead,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  fontSize: 15.0,
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timer,
                                      //themeData.textTheme.display4,
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 38.0,
                                        height: 1.1,
                                      ),
                                    );
                                  }),

                              new Padding(padding: EdgeInsets.all(20.0)),

                              new Container(
                                //scrollDirection: Axis.vertical,
                                alignment: Alignment.center,

                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Вопрос ${questionNumber + 1} из ${widget.catQues.length}",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                    new Text(
                                      "Счет: $finalScore",
                                      style: new TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //image
                              new Padding(padding: EdgeInsets.all(5.0)),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  "Q${questionNumber + 1}: ${widget.catQues[questionNumber]['question']}",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    _isButtonDisabled ? null : aftersubmitA();
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['a']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //  new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    _isButtonDisabled ? null : aftersubmitB();
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['b']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                              //    ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //    new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    _isButtonDisabled ? null : aftersubmitC();
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['c']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              //     ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //     new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    _isButtonDisabled ? null : aftersubmitD();
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['d']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              //      ),

                              new Padding(padding: EdgeInsets.all(15.0)),

                              new Container(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  alignment: Alignment.bottomCenter,
                                  child: new MaterialButton(
                                      padding: const EdgeInsets.only(
                                          right: 8.0,
                                          left: 8.0,
                                          top: 6.0,
                                          bottom: 8.0),
                                      minWidth: 400.0,
                                      height: 50.0,
                                      color: Colors.blue[900],
                                      onPressed: () {
                                        Future<String> _login() async {
                                          try {
                                            var url = APIData.submitQuestionApi;
                                            // ignore: deprecated_member_use
                                            var ans =
                                                await http.post(url, headers: {
                                              HttpHeaders.AUTHORIZATION:
                                                  fullData
                                            }, body: {
                                              "question_id":
                                                  "${widget.catQues[questionNumber]['id']}",
                                              "user_answer": "0",
                                              "answer":
                                                  "${widget.catQues[questionNumber]['answer']}",
                                            });
                                            updateQuestion();
                                            return (ans.body);
                                          } on SocketException catch (_) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            print('not connected');
                                            return null;
                                          }
                                        }

                                        _login();
                                      },
                                      child: new Text(
                                        "Далее",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      } else {
        return new Scaffold(
          body: new WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                body: new Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text(
                                "Осталось",
                                // style: themeData.textTheme.subhead,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  fontSize: 15.0,
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timer,
                                      //themeData.textTheme.display4,
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 38.0,
                                        height: 1.1,
                                      ),
                                    );
                                  }),

                              new Padding(padding: EdgeInsets.all(20.0)),

                              new Container(
                                //scrollDirection: Axis.vertical,
                                alignment: Alignment.center,

                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Вопрос ${questionNumber + 1} из ${widget.catQues.length}",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                    new Text(
                                      "Счет: $finalScore",
                                      style: new TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              new ListTile(
                                title: new MaterialButton(
                                    height: 50.0,
                                    color: Colors.green.shade400,
                                    textColor: Colors.white,
                                    child: new Container(
                                      child: new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.play_arrow),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB(
                                                105.0, 3.0, 0.0, 0.0),
                                            child: Text("Воспроизвести видео"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      playYoutubeVideoEdit();
                                    }),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  "Q${questionNumber + 1}: ${widget.catQues[questionNumber]['question']}",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("A" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['a']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //  new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("B" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['b']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                              //    ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //    new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("C" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['c']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              //     ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //     new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("D" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['d']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(15.0)),

                              new Container(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  alignment: Alignment.bottomCenter,
                                  child: new MaterialButton(
                                      padding: const EdgeInsets.only(
                                          right: 8.0,
                                          left: 8.0,
                                          top: 6.0,
                                          bottom: 8.0),
                                      minWidth: 400.0,
                                      height: 50.0,
                                      color: Colors.blue[900],
                                      onPressed: () {
                                        Future<String> _login() async {
                                          try {
                                            var url = APIData.submitQuestionApi;
                                            // ignore: deprecated_member_use
                                            var ans =
                                                await http.post(url, headers: {
                                              HttpHeaders.AUTHORIZATION:
                                                  fullData
                                            }, body: {
                                              "question_id":
                                                  "${widget.catQues[questionNumber]['id']}",
                                              "user_answer": "0",
                                              "answer":
                                                  "${widget.catQues[questionNumber]['answer']}",
                                            });
                                            updateQuestion();
                                            return (ans.body);
                                          } on SocketException catch (_) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            print('not connected');
                                            return null;
                                          }
                                        }

                                        _login();
                                      },
                                      child: new Text(
                                        "Далее",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      }
    } else {
      if (video == "null") {
        return new Scaffold(
          body: new WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                body: new Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text(
                                "Осталось",
                                // style: themeData.textTheme.subhead,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  fontSize: 15.0,
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timer,
                                      //themeData.textTheme.display4,
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 38.0,
                                        height: 1.1,
                                      ),
                                    );
                                  }),

                              new Padding(padding: EdgeInsets.all(20.0)),

                              new Container(
                                //scrollDirection: Axis.vertical,
                                alignment: Alignment.center,

                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Вопрос ${questionNumber + 1} из ${widget.catQues.length}",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                    new Text(
                                      "Счет: $finalScore",
                                      style: new TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //image
                              new Padding(padding: EdgeInsets.all(5.0)),

                              new Image.network(
                                APIData.questionImage +
                                    "${widget.catQues[questionNumber]['question_img']}",
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  "Q${questionNumber + 1}: ${widget.catQues[questionNumber]['question']}",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("A" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['a']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //  new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("B" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['b']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                              //    ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //    new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("C" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['c']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              //     ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //     new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("D" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['d']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(15.0)),

                              new Container(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  alignment: Alignment.bottomCenter,
                                  child: new MaterialButton(
                                      padding: const EdgeInsets.only(
                                          right: 8.0,
                                          left: 8.0,
                                          top: 6.0,
                                          bottom: 8.0),
                                      minWidth: 400.0,
                                      height: 50.0,
                                      color: Colors.blue[900],
                                      onPressed: () {
                                        Future<String> _login() async {
                                          try {
                                            var url = APIData.submitQuestionApi;
                                            // ignore: deprecated_member_use
                                            var ans =
                                                await http.post(url, headers: {
                                              HttpHeaders.AUTHORIZATION:
                                                  fullData
                                            }, body: {
                                              "question_id":
                                                  "${widget.catQues[questionNumber]['id']}",
                                              "user_answer": "0",
                                              "answer":
                                                  "${widget.catQues[questionNumber]['answer']}",
                                            });
                                            updateQuestion();
                                            return (ans.body);
                                          } on SocketException catch (_) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            print('not connected');
                                            return null;
                                          }
                                        }

                                        _login();
                                      },
                                      child: new Text(
                                        "Далее",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      } else {
        return new Scaffold(
          body: new WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                body: new Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text(
                                "Осталось",
                                // style: themeData.textTheme.subhead,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  fontSize: 15.0,
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timer,
                                      //themeData.textTheme.display4,
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 38.0,
                                        height: 1.1,
                                      ),
                                    );
                                  }),

                              new Padding(padding: EdgeInsets.all(20.0)),

                              new Container(
                                //scrollDirection: Axis.vertical,
                                alignment: Alignment.center,

                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Вопрос ${questionNumber + 1} из ${widget.catQues.length}",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                    new Text(
                                      "Счет: $finalScore",
                                      style: new TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //image
                              new Padding(padding: EdgeInsets.all(5.0)),

                              new Image.network(
                                APIData.questionImage +
                                    "${widget.catQues[questionNumber]['question_img']}",
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new ListTile(
                                title: new MaterialButton(
                                    height: 50.0,
                                    color: Colors.green.shade400,
                                    textColor: Colors.white,
                                    child: new Container(
                                      child: new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.play_arrow),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB(
                                                4.0, 4.0, 0.0, 0.0),
                                            child: Text("Воспроизвести видео"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      playYoutubeVideoEdit();
                                    }),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  "Q${questionNumber + 1}: ${widget.catQues[questionNumber]['question']}",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(10.0)),

                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("A" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "A",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['a']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //  new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("B" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "B",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['b']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                              //    ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //    new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("C" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "C",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['c']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              //     ),

                              new Padding(padding: EdgeInsets.all(5.0)),

                              //     new Flexible(
                              new Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: new MaterialButton(
                                  padding: const EdgeInsets.only(
                                      right: 8.0,
                                      left: 8.0,
                                      top: 6.0,
                                      bottom: 8.0),
                                  minWidth: 400.0,
                                  height: 50.0,
                                  color: Color.fromRGBO(64, 75, 96, 1.0),
                                  onPressed: () {
                                    if ("D" ==
                                        "${widget.catQues[questionNumber]['answer']}") {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          finalScore =
                                              (finalScore) + (widget.perQMark);
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Correct");
                                    } else {
                                      Future<String> _login() async {
                                        try {
                                          var url = APIData.submitQuestionApi;
                                          // ignore: deprecated_member_use
                                          var ans =
                                              await http.post(url, headers: {
                                            HttpHeaders.AUTHORIZATION: fullData
                                          }, body: {
                                            "question_id":
                                                "${widget.catQues[questionNumber]['id']}",
                                            "user_answer": "D",
                                            "answer":
                                                "${widget.catQues[questionNumber]['answer']}",
                                          });
                                          updateQuestion();
                                          return (ans.body);
                                        } on SocketException catch (_) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('not connected');
                                          return null;
                                        }
                                      }

                                      _login();
                                      debugPrint("Wrong");
                                    }
                                  },
                                  child: new Text(
                                    "${widget.catQues[questionNumber]['d']}",
                                    softWrap: true,
                                    maxLines: 10,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(15.0)),

                              new Container(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  alignment: Alignment.bottomCenter,
                                  child: new MaterialButton(
                                      padding: const EdgeInsets.only(
                                          right: 8.0,
                                          left: 8.0,
                                          top: 6.0,
                                          bottom: 8.0),
                                      minWidth: 400.0,
                                      height: 50.0,
                                      color: Colors.blue[900],
                                      onPressed: () {
                                        Future<String> _login() async {
                                          try {
                                            var url = APIData.submitQuestionApi;
                                            // ignore: deprecated_member_use
                                            var ans =
                                                await http.post(url, headers: {
                                              HttpHeaders.AUTHORIZATION:
                                                  fullData
                                            }, body: {
                                              "question_id":
                                                  "${widget.catQues[questionNumber]['id']}",
                                              "user_answer": "0",
                                              "answer":
                                                  "${widget.catQues[questionNumber]['answer']}",
                                            });
                                            updateQuestion();
                                            return (ans.body);
                                          } on SocketException catch (_) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            print('not connected');
                                            return null;
                                          }
                                        }

                                        _login();
                                      },
                                      child: new Text(
                                        "Далее",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      }
    }
  }

  void updateQuestion() {
    setState(() {
      _isButtonDisabled = false;
      if (questionNumber == widget.catQues.length - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary2(
                    perQMark: widget.perQMark,
                    qCount: widget.qCount,
                    totalM: widget.totalM,
                    score: finalScore)));
      } else {
        if (timer == '0:00') {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new Summary2(
                      perQMark: widget.perQMark,
                      qCount: widget.qCount,
                      totalM: widget.totalM,
                      score: finalScore)));
        } else {
          questionNumber++;
        }
      }
    });
  }

  void dispose() {
    try {
      controller.dispose();
      pageController.cancel();
      subscription.cancel();
      super.dispose();
      // ConnectivityResult.wifi
    } catch (exception) {
      print(exception.toString());
    }
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
      //  ques;
    });
  }
}

class Result extends StatefulWidget {
  final id;
  final perQMark;
  final qCount;
  final totalM;
  final myMark;
  Result(
      {Key key, this.id, this.perQMark, this.qCount, this.totalM, this.myMark})
      : super(key: key);

  @override
  ResultState createState() => ResultState();
}

class ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 100.0)),
            new Container(
              height: 500.0,
              child: IntrinsicHeight(
                // decoration: new BoxDecoration(color: Colors.grey),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Всего вопросов",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.qCount}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Мои баллы",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.myMark}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          // padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Баллов за вопрос",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.perQMark}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Всего баллов",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.totalM}"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: new Container(
          alignment: Alignment(0.15, -.0),
          child: new MaterialButton(
            height: 50.0,
            color: Colors.green.shade400,
            textColor: Colors.white,
            onPressed: () {
              questionNumber = 0;
              finalScore = 0;
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new QuizHome(
//              name: name,
//              email: email,
//              nameInitial: nameInitial,
                      ));
              Navigator.of(context).push(router);
            },
            child: new Text(
              "Перейти на страницу тестов",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),

//      body: Container(
//        child: bodyData(),
//      ),
      ),
    );
  }
}

class Summary2 extends StatefulWidget {
  final perQMark;
  final qCount;
  final totalM;
  final score;
  Summary2({Key key, this.perQMark, this.qCount, this.totalM, this.score})
      : super(key: key);
  @override
  Summary2State createState() => Summary2State();
}

class Summary2State extends State<Summary2> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 100.0)),
            new Container(
              height: 500.0,
              child: IntrinsicHeight(
                // decoration: new BoxDecoration(color: Colors.grey),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Всего вопросов",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.qCount}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Мои баллы",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.score}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          // padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Баллов за вопрос",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.perQMark}"),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Divider(
                          height: 10.0,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          height: 30.0,
                          width: 1.0,
                          color: Colors.black.withOpacity(0.1),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    new Flexible(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("Всего баллов",
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          new Divider(
                            height: 1.0,
                          ),
                          new Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                            height: 50.0,
                            // decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("${widget.totalM}"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: new Container(
          alignment: Alignment(0.15, -.0),
          child: new MaterialButton(
            height: 50.0,
            color: Colors.green.shade400,
            textColor: Colors.white,
            onPressed: () {
              questionNumber = 0;
              finalScore = 0;
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new QuizHome());
              Navigator.of(context).push(router);
            },
            child: new Text(
              "Перейти на страницу тестов",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

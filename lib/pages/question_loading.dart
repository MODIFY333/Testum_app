import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:testum/apidata/apidata.dart';
import 'package:testum/global.dart';
import 'package:testum/pages/networkerror_afterlogin.dart';
import 'package:testum/pages/quiz_questions.dart';
import 'package:testum/ui/widgets/CustomShowDialog.dart';

class QuestionLoading extends StatefulWidget {
  QuestionLoading({Key key, this.time, this.id, this.marks}) : super(key: key);
  final id;
  final time;
  final marks;

  @override
  _QuestionLoadingState createState() => _QuestionLoadingState();
}

class _QuestionLoadingState extends State<QuestionLoading> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      getData();
    });
  }

  Future<String> getData() async {
    try {
      var qCount;
      var qRight;
      var myMark;
      var totalM;

      final questions = await http
          .get(Uri.encodeFull(APIData.questionApi + "${widget.id}"), headers: {
        HttpHeaders.AUTHORIZATION: fullData // ignore: deprecated_member_use
      });

      var url = APIData.resultApi + "/${widget.id}";
      // ignore: deprecated_member_use
      var ans =
          await http.get(url, headers: {HttpHeaders.AUTHORIZATION: fullData});
      var resultDetails = json.decode(ans.body);
      print(resultDetails);
      print("test");
      qCount = resultDetails['count'];
      qRight = resultDetails['right'];
      print(qCount);
      print("qQount: ${widget.marks is String}");

      print("qQount: ${qRight is int}");

      int Markscount;
      dynamic mrRuntime = widget.marks;
      switch (mrRuntime.runtimeType) {
        case int:
          {
            Markscount = mrRuntime == null ? 0 : mrRuntime;
            print("aaaaa:$mrRuntime");
          }
          break;
        case String:
          {
            Markscount = mrRuntime == null ? 0 : int.parse(mrRuntime);
            print("bbbbb:$mrRuntime");
          }
          break;
        case double:
          {
            Markscount = mrRuntime == null ? 0 : int.parse(mrRuntime);
            print("cccc:$mrRuntime");
          }
          break;
      }
//
      int TimeCount;
      dynamic tmRuntime = widget.time;
      switch (tmRuntime.runtimeType) {
        case int:
          {
            TimeCount = tmRuntime == null ? 0 : tmRuntime;
          }
          break;
        case String:
          {
            TimeCount = tmRuntime == null ? 0 : double.parse(tmRuntime);
          }
          break;
        case double:
          {
            TimeCount = tmRuntime == null ? 0 : tmRuntime;
          }
          break;
      }

      totalM = qCount * Markscount;

      myMark = qRight * Markscount;

      var que;
      List ques;
      que = json.decode(questions.body);
      print(questions.statusCode);
      if (questions.statusCode == 300) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Result(
                      id: widget.id,
                      perQMark: Markscount,
                      qCount: qCount,
                      totalM: totalM,
                      myMark: myMark,
                    )));
      } else {
        ques = que['questions'];
        quizQuestion() {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new QuizQuestion(
                        id: widget.id,
                        timer: TimeCount,
                        catQues: ques,
                        perQMark: widget.marks,
                        qCount: qCount,
                        totalM: totalM,
                      )));
        }

        noQuestion() {
          showDialog(
            context: context,
            builder: (context) => new CustomAlertDialog(
              title: new Text(
                'Alert..!',
                textAlign: TextAlign.left,
              ),
              content: new Container(
                width: 260.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                ),
                child: new Column(
                  children: <Widget>[
                    new Text(
                      'Нет данных о вопросах',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          );
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }

        ques.isEmpty ? noQuestion() : quizQuestion();
      }
    } on SocketException catch (_) {
      var router = new MaterialPageRoute(
          builder: (BuildContext context) => new NoNetwork());
      Navigator.of(context).push(router);
      print('not connected');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(58, 66, 86, 1.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Ваш тест скоро начнется",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

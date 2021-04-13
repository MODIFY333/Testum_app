import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testum/apidata/apidata.dart';
import 'package:testum/global.dart';
import 'package:http/http.dart' as http;
import 'package:testum/pages/networkerror_afterlogin.dart';
import 'package:testum/pages/question_loading.dart';
import 'package:testum/pages/quiz_questions.dart';

void main() {
  runApp(new MaterialApp(
    home: new QuickQuiz(),
  ));
}

class QuickQuiz extends StatefulWidget {
  QuickQuiz(
      {Key key,
      this.time,
      this.id,
      this.title,
      this.description,
      this.perQMark,
      this.timer,
      this.marks})
      : super(key: key);

  final title;
  final description;
  final perQMark;
  final timer;
  final id;
  final time;
  final marks;
  @override
  State<StatefulWidget> createState() {
    return new QuickQuizState();
  }
}

class QuickQuizState extends State<QuickQuiz> {
  final topAppBar = AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text("Testum"),
    centerTitle: true,
    actions: <Widget>[],
  );
  @override
  Widget build(BuildContext context) {
    final makeBody = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new WillPopScope(
          onWillPop: () async => true,
          child: new Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                final makeListTile = ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  title: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    title: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: ListTile(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      title: Text(
                        widget.perQMark,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: ListTile(
                        title: Text(
                          widget.timer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    startQuiz();
                  },
                );

                final makeCard = Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
        ),
        new Container(
            padding: EdgeInsets.all(10.0),
            child: new Text(
              "Нажмите на карточку чтобы начать",
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ))
      ],
    );
    return new Scaffold(
      appBar: topAppBar,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }

  startQuiz() {
    var router = new MaterialPageRoute(
        builder: (BuildContext context) => new QuestionLoading(
              id: widget.id,
              marks: widget.marks,
              time: widget.time,
            ));
    Navigator.of(context).push(router);
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
      qCount = resultDetails['count'];
      qRight = resultDetails['right'];
      print(qCount);
      totalM = qCount * widget.marks;
      myMark = qRight * widget.marks;

      var que;
      List ques;
      que = json.decode(questions.body);
      print(questions.statusCode);
      if (questions.statusCode == 300) {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Подождите'),
            content: new Text('Ваш тест начнется через несколько минут'),
          ),
        );
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Result(
                      id: widget.id,
                      perQMark: widget.marks,
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
                        timer: widget.time,
                        catQues: ques,
                        perQMark: widget.marks,
                        qCount: qCount,
                        totalM: totalM,
                      )));
        }

        noQuestion() {
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Внимание'),
              content: new Text('Нет данных о вопросах'),
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
}

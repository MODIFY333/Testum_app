import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:testum/apidata/apidata.dart';
import 'package:testum/global.dart';
import 'package:testum/main.dart';
import 'package:testum/pages/home.dart';
import 'package:testum/pages/networkerror_beforelogin.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MaterialApp(
      home: LoadingScreen(),
    ));

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });

    Timer(Duration(seconds: 2), () {
      loginFromFIle();
    });
  }

  Future<String> loginFromFIle() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (fileExists) {
          print(fileContent);
          final accessToken = await http.post(APIData.tokenApi, body: {
            "email": fileContent['user'],
            "password": fileContent['pass'],
          });
          print(accessToken.body);
          var user = json.decode(accessToken.body);
          final response = await http.get(APIData.quizCatApi,
              // ignore: deprecated_member_use
              headers: {
                // ignore: deprecated_member_use
                HttpHeaders.AUTHORIZATION: "Bearer ${user['access_token']}!"
              });

          setState(() {
            fullData = "Bearer ${user['access_token']}!";
          });

          dataUser = json.decode(response.body);
          userDetail = dataUser['users'];
          userRole = userDetail['role'];
          userId = userDetail['id'];
          userName = userDetail['name'];
          userEmail = userDetail['email'];
          userMobile = userDetail['mobile'];
          userAddress = userDetail['address'];
          userCity = userDetail['city'];
          topicsData = dataUser['topics'];
          qData = dataUser['questions'];
          print(userDetail);
          setState(() {
            name = userName;
            nameInitial = userName[0];
            email = userEmail;
            if (userRole == 'A') {
              role = "Администратор";
            } else {
              role = "Студент";
            }
            if (userMobile == null) {
              mobile = "N/A";
            } else {
              mobile = userMobile;
            }
            if (userAddress == null) {
              address = "N/A";
            } else {
              address = userAddress;
            }
            if (userCity == null) {
              city = "N/A";
            } else {
              city = userCity;
            }
          });
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new QuizHome(
                    name: name,
                    email: email,
                    nameInitial: nameInitial,
                  ));
          Navigator.of(context).push(router);
          return (accessToken.body);
        } else {
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new Home());
          Navigator.of(context).push(router);
          print('connected');
        }
      }
    } on SocketException catch (_) {
      var router = new MaterialPageRoute(
          builder: (BuildContext context) => new NoNetworkL());
      Navigator.of(context).push(router);
      print('not connected');
    }

    return (null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 130, 148, 1),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55.0,
                      child: new Image.asset(
                        'images/logo.png',
                        scale: 3,
                        width: 70.0,
                        height: 70.0,
                        color: Color.fromRGBO(62, 130, 148, 1).withOpacity(1.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 50.0)),
                    Text(
                      "Testum",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
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
                        "Пожалуйста подождите",
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

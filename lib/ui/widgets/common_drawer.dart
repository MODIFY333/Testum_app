import 'dart:io';
import 'package:flutter/material.dart';
import 'package:testum/main.dart';
import 'package:testum/pages/home.dart';
import 'package:testum/profile/profile_one_page.dart';
import 'package:testum/global.dart';
import 'package:testum/ui/widgets/CustomShowDialog.dart';

class CommonDrawer extends StatefulWidget {
  CommonDrawer({Key key, this.name, this.email, this.nameInitial})
      : super(key: key);
  final String name;
  final String email;
  final String nameInitial;
  @override
  CommonDrawerState createState() => CommonDrawerState();
}

class CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(name),
            accountEmail: new Text(email),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.blue[900],
              child: new Text(nameInitial),
            ),
            decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
            margin: EdgeInsets.all(0.0),
          ),
          new ListTile(
            title: new Text("Домой"),
            trailing: new Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new QuizHome(
                        name: name,
                        email: email,
                        nameInitial: nameInitial,
                      ));
              Navigator.of(context).push(router);
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text("Мой профиль"),
            trailing: new Icon(Icons.person),
            onTap: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new ProfileOnePage(
                        name: name,
                        email: email,
                        nameInitial: nameInitial,
                      ));
              Navigator.of(context).push(router);
            },
          ),
          new ListTile(
            title: new Text("Выйти из пользователя"),
            trailing: new Icon(Icons.settings_power),
            onTap: () {
              deleteFile();
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new Home());
              Navigator.of(context).push(router);
            },
          ),
          new ListTile(
            title: new Text("Выйти"),
            trailing: new Icon(Icons.close),
            onTap: () {
              showDialog(
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
              );
            },
          ),
        ],
      ),
    );
  }

  void deleteFile() {
    print("Удаляю файл!");
    File file = new File(dir.path + "/" + fileName);
    file.delete();
    setState(() {
      fileExists = false;
    });
  }
}

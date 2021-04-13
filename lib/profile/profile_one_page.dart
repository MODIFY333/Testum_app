import 'package:flutter/material.dart';
import 'package:testum/global.dart';
import 'package:testum/ui/widgets/common_divider.dart';
import 'package:testum/ui/widgets/common_scaffold.dart';
import 'package:testum/ui/widgets/profile_tile.dart';

// ignore: must_be_immutable
class ProfileOnePage extends StatefulWidget {
  ProfileOnePage({Key key, this.name, this.email, this.nameInitial})
      : super(key: key);
  final String name;
  final String email;
  final String nameInitial;

  @override
  _ProfileOnePageState createState() => _ProfileOnePageState();
}

class _ProfileOnePageState extends State<ProfileOnePage> {
  var deviceSize;

  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.30,
        child: FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "$name",
                  subtitle: role,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[900],
                          child: new Text(nameInitial),
                          //foregroundColor: Colors.green,
                          radius: 30.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget accountColumn() => FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: deviceSize.height * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ProfileTile(title: "Адрес", subtitle: "$address"),

                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileTile(
                      title: "Город",
                      subtitle: "$city",
                    ),
//
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ProfileTile(
                      title: "Телефон",
                      subtitle: "$mobile",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileTile(
                      title: "Email",
                      subtitle: "$email",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[profileColumn(), CommonDivider(), accountColumn()],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        bodyData: bodyData(),
        showDrawer: true,
        floatBtn: true,
        quizAppBar: true,
        backGroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }
}

import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.0,
      // crossAxisAlignment: CrossAxisAlignment.start,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22.0, fontWeight: FontWeight.w700, color: textColor),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.3,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: textColor),
          ),
        ],
      ),
    );
  }
}

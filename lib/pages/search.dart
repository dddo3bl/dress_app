import 'package:flutter/material.dart';
import 'package:flutter_app/moduls/fetchapioneuser.dart';
import 'package:flutter_app/moduls/storyoneuser.dart';
import 'package:flutter_app/widget/clintslist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search_for_clint extends StatefulWidget {
  @override
  _Search_for_clintState createState() => _Search_for_clintState();
}

class _Search_for_clintState extends State<Search_for_clint> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      margin: EdgeInsets.only(top: size.height / 4),
      child: Center(
        child: Column(
          children: [
            Text(
              "مرحبا بك في خياط الرجل الانيق",
              style: TextStyle(fontSize: 30),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              "خياط الرجل الانيق للتفصيل",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              "يمكنك طلب تفصيل بسهولة وفي اي مكان واي زمان",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: 25)),
          ],
        ),
      ),
    );
  }
}

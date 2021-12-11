import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;

class NewclintSize extends StatefulWidget {
  @override
  _NewclintSizeState createState() => _NewclintSizeState();
}

class _NewclintSizeState extends State<NewclintSize> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(""),
          content: new Text("تمت اضافة البيانات بنجاح"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var hightbutton = TextEditingController();
  var chistcontrolr = TextEditingController();
  var choldercontrolr = TextEditingController();
  var bttmcontrolr = TextEditingController();
  var lowerpartcontlor = TextEditingController();
  var handhightcontrolr = TextEditingController();
  var mucelscontroler = TextEditingController();
  var rescontrolr = TextEditingController();
  var nickcontrolr = TextEditingController();

  getsize() async {
    var email = UserSimplePrefrences.getEmail();
    var username = UserSimplePrefrences.getUsername();
    var userid = UserSimplePrefrences.getId();
    var phone = UserSimplePrefrences.getphone();
    // var url = "http://10.0.2.2:3000/newclint/newclintsize";
    var url = "https://dressmobile.herokuapp.com/newclint/newclintsize";
    var response = await http.post(
      url,
      body: jsonEncode({
        "username": username,
        "email": email,
        "hight": hightbutton.text,
        "bttn": bttmcontrolr.text,
        "cholder": choldercontrolr.text,
        "chist_whdth": chistcontrolr.text,
        "nick": nickcontrolr.text,
        "hand_length": handhightcontrolr.text,
        "hand_whdth": rescontrolr.text,
        "muscle": mucelscontroler.text,
        "lower_part": lowerpartcontlor.text,
        "userid": userid,
        "clint_phone": phone
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 210) {
      _showDialog(context);
      Navigator.of(context).pushReplacementNamed("home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Image(image: AssetImage("assets/take size.jpg")),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey),
                width: 380,
                height: 50,
                margin: EdgeInsets.only(top: 300, left: 20),
                child: Container(
                    margin: EdgeInsets.only(top: 8, right: 25),
                    child: Text(
                      "الرجاء ادخال المقاسات كما موضح في الرسم",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 370, right: 50),
                child: Column(
                  children: [
                    sizesleabel("ادخل مقاس الطول كما موضح في الصورة",
                        "ادخل الطول", hightbutton),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل وسع الصدر كما موضح في الصورة",
                        "ادخل وسع الصدر", chistcontrolr),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل بين الكتفيين كما موضح في الصورة",
                        "الاكتاف", choldercontrolr),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل وسع البطن كما موضح في الصورة",
                        "ادخل وسع البطن", bttmcontrolr),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل مقاس اسفل الخصر كما كوضح في الصورة",
                        "ادخل اسفل الخصر", lowerpartcontlor),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل طول اليد كما موضح في الصورة",
                        "ادخل طول اليد", handhightcontrolr),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل مقاس العضلات كما موضح في الصورة",
                        "ادخل مقاس العضلات", mucelscontroler),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل مقاس الرسغ كما موضح في الصورة",
                        "ادخل مقاس الرسغ", rescontrolr),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    sizesleabel("ادخل مقاس الرقبة كما موضح في الصورة",
                        "ادخل مقاس الرقبة", nickcontrolr),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                margin: EdgeInsets.only(top: 930, right: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 100),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.tealAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.red))),
                        ),
                        onPressed: getsize,
                        child: Text(
                          "حفظ البيانات",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Container sizesleabel(
      String myhint, String mylabel, TextEditingController myControlr) {
    return Container(
      height: 50,
      width: 300,
      child: TextField(
        controller: myControlr,
        showCursor: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.redAccent,
                width: 1.5,
              )),
          hintText: myhint,
          labelText: mylabel,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(5),
          ),
          hintStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
              fontWeight: FontWeight.w700),
          labelStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

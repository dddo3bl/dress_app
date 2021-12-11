import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;

class MyAccunt extends StatefulWidget {
  @override
  _MyAccuntState createState() => _MyAccuntState();
}

class _MyAccuntState extends State<MyAccunt> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("تم"),
          content: new Text("تم تعديل البيانات بنجاح"),
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

  TextEditingController upusername = TextEditingController();
  TextEditingController upemail = TextEditingController();
  TextEditingController uppassword = TextEditingController();
  TextEditingController upphon = TextEditingController();

  String validusername(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون اسم المستخدم فارغ";
    }
    if (val.trim().length < 4) {
      return "يجب ان يكون اسم المستخدم اكثر من 4";
    }
    if (val.trim().length > 20) {
      return "يجب ان يكون اسم المستخدم اكثر من 20";
    }
  }

  String validpassword(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان تكون كلمة المرور فارغة";
    }
    if (val.trim().length < 4) {
      return "يجب ان تكون كلمة المرور اكثر من 4 احرف";
    }
    if (val.trim().length > 20) {
      return "يجب ان تكون كلمة المرور اكثر من 20 حرف";
    }
  }

  String validemail(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون البريد الالكتروني فارغ";
    }
    if (val.trim().length < 4) {
      return "يجب ان يكون البريد الاكتروني اكثر من 4 احرف";
    }
    if (val.trim().length > 20) {
      return "يجب ان يكون اسم المستخدم اكثر من 20";
    }
    RegExp regexp = new RegExp(pattern);
    if (!regexp.hasMatch(val)) {
      return "عنوان البريد الالكتروني غير صحيح";
    }
  }

  var getemail = UserSimplePrefrences.getEmail();
  var getpassword = UserSimplePrefrences.getPassword();
  var getphone = UserSimplePrefrences.getphone();
  saveChing() async {
    var url = "http://10.0.2.2:5000/newclint/personal";
    // var url = "https://dressmobile.herokuapp.com/newclint/personal";
    var response = await http.post(
      url,
      body: jsonEncode({
        "newemail": upemail.text != "" ? upemail.text : getemail,
        "email": getemail,
        "username": upusername.text != "" ? upusername.text : userame,
        "password": uppassword.text != "" ? uppassword.text : getpassword,
        "phone": upphon.text != "" ? upphon.text : getphone
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    var responsebosy = jsonDecode(response.body);
    if (response.statusCode == 220) {
      setState(() {
        UserSimplePrefrences.setUsername(responsebosy[0]['user_name']);
        UserSimplePrefrences.setEmail(responsebosy[0]['email']);
        UserSimplePrefrences.setPassword(
            responsebosy[0]['password'].toString());
        UserSimplePrefrences.setPhone(responsebosy[0]['phone'].toString());
        UserSimplePrefrences.setId(
            responsebosy[0]['user_mubile_id'].toString());
      });
      _showDialog(context);
    }
  }

  var pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  var password;
  var username;
  var email;
  var userame;
  var phone;
  bool logout = false;
  getpref() async {
    userame = UserSimplePrefrences.getUsername();
    email = UserSimplePrefrences.getEmail();
    phone = UserSimplePrefrences.getphone();
    if (userame != null) {
      setState(() {
        userame = UserSimplePrefrences.getUsername();
        email = UserSimplePrefrences.getEmail();
        phone = UserSimplePrefrences.getphone();
      });
    } else {
      setState(() {
        logout = false;
      });
    }
  }

  clear() async {
    UserSimplePrefrences.remove();
    Navigator.of(context).pushReplacementNamed("home");
  }

  initState() {
    getpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  margin: EdgeInsets.only(top: 80),
                  height: 80,
                  width: 400,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 150),
                    child: Text(
                      "معلوماتك",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.8), fontSize: 25),
                    ),
                  ),
                ),

// start clint name

                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: EdgeInsets.only(top: 180),
                  color: Colors.black.withOpacity(0.3),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "اسم العميل:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          userame,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: upusername,
                          validator: validusername,
                          autovalidate: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                )),
                            hintText: userame,
                            labelText: "ادخل الاسم للتعديل",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red),
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
                      ),
                    ],
                  ),
                ),

// end clint name

// start clint email

                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: EdgeInsets.only(top: 320),
                  color: Colors.black.withOpacity(0.3),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "البريد الالكتروني لعميل:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          email,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: upemail,
                          validator: validemail,
                          autovalidate: true,
                          showCursor: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                )),
                            hintText: email,
                            labelText: "ادخل البريد الالكتروني للتعديل",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red),
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
                      ),
                    ],
                  ),
                ),

// end clint email

// start clint phone
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: EdgeInsets.only(top: 450),
                  color: Colors.black.withOpacity(0.3),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          " رقم الهاتف:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          phone,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          autovalidate: true,
                          controller: upphon,
                          validator: validemail,
                          showCursor: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                )),
                            hintText: email,
                            labelText: "ادخل رقم الهاتف للتعديل",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red),
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
                      ),
                    ],
                  ),
                ),

// end clint phone

// start passs

                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: EdgeInsets.only(top: 580),
                  color: Colors.black.withOpacity(0.3),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "كلمة المرور :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          email,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: uppassword,
                          validator: validemail,
                          showCursor: true,
                          autovalidate: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                )),
                            hintText: password,
                            labelText: "ادخل البريد الالكتروني للتعديل",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red),
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
                      ),
                    ],
                  ),
                ),

// end password

// start update buton

                Container(
                  margin: EdgeInsets.only(top: 720, right: 90),
                  height: 80,
                  width: 200,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.red)),
                      ),
                    ),
                    onPressed: saveChing,
                    child: Text(
                      "تعديل البيانات",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),

// end update button

// start logout button

                Container(
                  margin: EdgeInsets.only(top: 820, right: 90),
                  height: 80,
                  width: 200,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.red)),
                      ),
                    ),
                    onPressed: clear,
                    child: Text(
                      "تسجل الخروج",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

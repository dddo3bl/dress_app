import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  LogIn();

  @override
  _LogInState createState() => _LogInState();
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Alert!!"),
        content: new Text("تأكد من البريد الالكتروني وكلمة المرور"),
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

showdialong(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CircularProgressIndicator(),
        );
      });
}

class _LogInState extends State<LogIn> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confpassword = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  GlobalKey<FormState> formstateSingIn = new GlobalKey<FormState>();
  GlobalKey<FormState> formstateSingUp = new GlobalKey<FormState>();

  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  bool isloading = false;

  savePref(String email, String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_name", username);
    preferences.setString("email", email);
    // print(preferences.getString("user_name"));
    // print(preferences.getString("email"));
  }

  String validateMobile(String value) {
    String pattternmo = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattternmo);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String validglobal(String val) {
    if (val.isEmpty) {
      return "field empty";
    }
  }

  String validusername(String val) {
    if (val.trim().isEmpty) {
      return "لا يمكن ان يكون اسم المستخدم فارغ";
    }
    if (val.trim().length < 4) {
      return "يجب ان يكون اسم المستخدم اكثر من 4";
    }
    if (val.trim().length > 20) {
      return "يجب ان يكون اسم المستخدم اقل من 20";
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

  String validconfpassord(String val) {
    if (val != password.text) {
      return "كلمة المرور غير متطباقة";
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

  singin() async {
    var formdata = formstateSingIn.currentState;
    if (formdata.validate()) {
      formdata.save();
      setState(() {
        isloading = true;
      });
      // showdialong(context);
      // var url = "https://dressmobile.herokuapp.com/newclint/login";
      var url = "http://10.0.2.2:5000/newclint/login";
      // var url = "http://127.0.0.1:3000/newclint/login";

      var response = await http.post(
        url,
        body: jsonEncode({"email": username.text, "password": password.text}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      var responsbody = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 205) {
        print(responsbody);
        UserSimplePrefrences.setUsername(responsbody['rows'][0]['user_name']);
        UserSimplePrefrences.setEmail(responsbody['rows'][0]['email']);
        UserSimplePrefrences.setPassword(
            responsbody['rows'][0]['password'].toString());
        UserSimplePrefrences.setPhone(
            responsbody['rows'][0]['phone'].toString());
        UserSimplePrefrences.setId(
            responsbody['rows'][0]['user_mubile_id'].toString());
        Navigator.of(context).pushReplacementNamed("home");
      } else if (response.statusCode == 210) {
        _showDialog(context);
        setState(() {
          isloading = true;
        });
      }
    }
  }

  singup() async {
    var formdata = formstateSingUp.currentState;
    if (formdata.validate()) {
      var url = "http://10.0.2.2:5000/newclint/singup";
      // var url = "https://dressmobile.herokuapp.com/newclint/singup";
      var response = await http.post(
        url,
        body: jsonEncode({
          "email": email.text,
          "password": password.text,
          "username": username.text,
          "phone": phone.text
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      print(response.statusCode);
      var responsebody = jsonDecode(response.body);
      if (response.statusCode == 220) {
        UserSimplePrefrences.setEmail(responsebody['result'][0]['email']);
        UserSimplePrefrences.setUsername(
            responsebody['result'][0]['user_name']);
        UserSimplePrefrences.setPhone(
            responsebody['result'][0]['phone'].toString());
        UserSimplePrefrences.setPassword(
            responsebody['result'][0]['password'].toString());
        UserSimplePrefrences.setId(
            responsebody['result'][0]['user_mubile_id'].toString());
        print(UserSimplePrefrences.getId());
        Navigator.of(context).pushReplacementNamed("home");
      } else if (response.statusCode == 210) {
        _showDialog(context);
      }
    } else {
      print("not object");
    }
  }

  bool passwordVis = true;
  TapGestureRecognizer _changesing;
  bool showsingin = true;
  var userame;
  @override
  void initState() {
    _changesing = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsingin = !showsingin;
          print(showsingin);
        });
      };

    super.initState();
  }

  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    // var mdh = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  // height: double.infinity,
                  // width: double.infinity,
                  ),
              buildPositionetop(mdw),
              buildpositinbuttm(mdw),
              buildcontaineravatar(mdw),
              showsingin
                  ? buildFormBoxsingin(mdw, mdh)
                  : buildFormBoxsingup(mdw),
              Container(
                margin: EdgeInsets.only(top: showsingin ? 520 : 680, right: 70),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      showsingin
                          ? InkWell(
                              onTap: () {},
                              child: Text(
                                "هل نسيت كلمة المرور",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 24,
                      ),
                      RaisedButton(
                        elevation: 10,
                        color: Colors.lightBlue,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        onPressed: showsingin ? singin : singup,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              showsingin ? "تسجيل الدخول" : "انشاء حساب",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              children: <TextSpan>[
                                TextSpan(
                                    text: showsingin
                                        ? "ليس لديك حساب ؟" //
                                        : " لديك حساب يمكنك  "),
                                TextSpan(
                                    recognizer: _changesing,
                                    text: showsingin
                                        ? "انشاء حساب من هنا"
                                        : "تسجيل دخول",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700)),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Center buildFormBoxsingin(double mdw, double mdh) {
    return Center(
      child: Form(
        key: formstateSingIn,
        child: Container(
          height: mdh,
          width: mdw / 1.2,
          child: Container(
            padding: EdgeInsets.only(top: 290),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFormField(
                    "اسم المستخدم",
                    false,
                    username,
                    Icon(Icons.person_outline),
                    validusername,
                    TextInputType.text),
                // Start Text UserName
                Padding(padding: EdgeInsets.all(8)),
                // End Text Username
                // Start Text Password
                textFormField("كلمة المرور", true, password,
                    Icon(Icons.visibility), validpassword, TextInputType.text),
                // End Text PassWord
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFormField(String hinttext, bool pass,
      TextEditingController mycontroller, myicon, myvalid, mywidget) {
    return TextFormField(
      keyboardType: mywidget,
      autovalidate: true,
      validator: myvalid,
      controller: mycontroller,
      obscureText: pass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(4),
        hintText: hinttext,
        filled: true,
        // fillColor: Colors.grey[200],
        icon: myicon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide: BorderSide(
              color: Colors.grey[500], style: BorderStyle.solid, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }

  Center buildFormBoxsingup(double mdw) {
    return Center(
      child: Form(
        key: formstateSingUp,
        child: Container(
          margin: EdgeInsets.only(top: 260),
          height: 450,
          width: mdw / 1.2,
          child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              // تحريك الشاشة من الاعلى الى الاسفل
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Start Text UserName
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: textFormField(
                        "اسم المستخد",
                        false,
                        username,
                        Icon(Icons.person_outline),
                        validusername,
                        TextInputType.text),
                  ),
                  // End Text Username
                  // Start Text Password
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: textFormField(
                        "كلمة المرور",
                        true,
                        password,
                        Icon(Icons.visibility),
                        validpassword,
                        TextInputType.text),
                  ),
                  // End Text PassWord
                  // Start repassword
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: textFormField(
                        "اعد كلمة المرور ",
                        true,
                        confpassword,
                        Icon(Icons.visibility),
                        validconfpassord,
                        TextInputType.text),
                  ),
                  // End repassword
                  // start E-mail
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: textFormField(
                        "البريد الالكتروني ",
                        false,
                        email,
                        Icon(Icons.email_outlined),
                        validemail,
                        TextInputType.emailAddress),
                  ),
                  // End E-mail
                  // Start phone
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: textFormField(
                        "رقم الهاتف ",
                        false,
                        phone,
                        Icon(Icons.phone_android_outlined),
                        validateMobile,
                        TextInputType.number),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildcontaineravatar(double mdw) {
    return Container(
      height: mdw,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "مرحبا بك في خياط الرجل الانيق",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    Text(
                      showsingin ? "تسجيل الدخول" : "انشاء حساب",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 0)),
            Container(
              height: 140,
              width: 150,
              decoration: BoxDecoration(
                  color: showsingin ? Colors.yellow : Colors.grey[700],
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, blurRadius: 4, spreadRadius: 1)
                  ]),
              child: Stack(
                children: [
                  Positioned(
                    top: 45,
                    right: 50,
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 85,
                    child: Icon(
                      Icons.arrow_back,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildPositionetop(double mdw) {
    return Positioned(
        child: Transform.scale(
      scale: 1.3,
      child: Transform.translate(
        offset: Offset(0, -mdw) / 1.7,
        child: Container(
          height: mdw,
          width: mdw,
          decoration: BoxDecoration(
              color: showsingin ? Colors.grey[800] : Colors.blue,
              borderRadius: BorderRadius.circular(mdw)),
        ),
      ),
    ));
  }

  Positioned buildpositinbuttm(double mdw) {
    return Positioned(
      top: 300,
      right: mdw / 2,
      child: Container(
        height: mdw,
        width: mdw,
        decoration: BoxDecoration(
            color: showsingin
                ? Colors.blue[800].withOpacity(0.5)
                : Colors.grey[800].withOpacity(0.3),
            borderRadius: BorderRadius.circular(mdw)),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/clintstatus.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("الطلبات"),
          ),
          body: TTTT(),
        ),
      ),
    ]);
  }
}

class TTTT extends StatefulWidget {
  @override
  _TTTTState createState() => _TTTTState();
}

class _TTTTState extends State<TTTT> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("تأكد من رقم الفاتورة المبلغ "),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  File _file;
  TextEditingController thebatment = TextEditingController();
  TextEditingController invonum = TextEditingController();

  // image paicker
  Future pickercamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    // print(myfile.readAsString());
    setState(() {
      _file = File(myfile.path);
    });
  }

  confirm() async {
    if (invonum.text == "" && thebatment.text == "") {
      _showDialog(context);
      print("not ok");
    } else {
      String base64 = base64Encode(_file.readAsBytesSync());
      String imagename = _file.path.split("/").last;
      print(base64.length);
      print(imagename);

      var url = "http://10.0.2.2:5000/newclint/confirm";
      // var url = "https://dressmobile.herokuapp.com/newclint/confirm";

      var response = await http.post(
        url,
        body: jsonEncode({
          "userid": UserSimplePrefrences.getId(),
          "ordernum": invonum.text,
          "thebaymnt": thebatment.text
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );

      var responsbody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("ok");
        print(response.statusCode);
      } else {
        print("not ok");
        print(response.statusCode);
      }
    }
  }

  statusClint() async {
    var url = "http://10.0.2.2:5000/newclint/status";
    // var url = "https://dressmobile.herokuapp.com/newclint/status";
    var response = await http.post(
      url,
      body: jsonEncode({"userid": UserSimplePrefrences.getId()}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 210) {
      var responsbody = jsonDecode(response.body);
      print(responsbody);
      return responsbody;
    }
  }

  @override
  void initState() {
    statusClint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder(
              future: statusClint(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Container(
                            width: 400,
                            height: 200,
                            child: Status(
                              clint_order: snapshot.data[i]["clint_orderid"],
                              bayed: snapshot.data[i]["bayed"],
                              total_price: snapshot.data[i]["total_price"],
                              is_bayed: snapshot.data[i]["is_bayed"],
                              order_time: snapshot.data[i]["order_time"],
                            ));
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),

          Container(
            height: 100,
            width: 400,
            child: Container(
              margin: EdgeInsets.only(right: 70, top: 10),
              child: Text(
                " ادخل رقم الفاتورة والمبلغ لتأكيد الطلب",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),

// ============================================= starts bayed textFaild
          Container(
            height: 50,
            width: 400,
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pinkAccent.withOpacity(.3)),
                  margin: EdgeInsets.only(right: 20),
                  child: Container(
                      margin: EdgeInsets.only(right: 20, top: 5),
                      child: Text(
                        "ادخل المبلغ",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 200,
                  height: 50,
                  // color: Colors.pinkAccent.withOpacity(.3),
                  child: Container(
                    child: TextFormField(
                      controller: thebatment,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.teal,
                              style: BorderStyle.solid,
                              width: 3),
                        ),
                        fillColor: Colors.red,
                        focusColor: Colors.teal,
                        hintText: "ادخل المبلغ",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//================================ starts invo
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            height: 50,
            width: 400,
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pinkAccent.withOpacity(.3)),
                  margin: EdgeInsets.only(right: 20),
                  child: Container(
                      margin: EdgeInsets.only(right: 20, top: 5),
                      child: Text(
                        "ادخل رقم الفاتورة",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 200,
                  height: 50,
                  // color: Colors.pinkAccent.withOpacity(.3),
                  child: Container(
                    child: TextFormField(
                      controller: invonum,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.teal,
                              style: BorderStyle.solid,
                              width: 3),
                        ),
                        fillColor: Colors.red,
                        focusColor: Colors.teal,
                        hintText: "ادخل رقم الفاتورة",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
//=======================image
          RaisedButton(
            child: Text("قم بتصوير الايصال"),
            onPressed: pickercamera,
          ),
          RaisedButton(
            child: Text("تأكيد"),
            onPressed: confirm,
          ),
        ]),
      ),
    );
  }
}

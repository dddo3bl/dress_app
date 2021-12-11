import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;

class ClintSizeDetiles extends StatefulWidget {
  final clint_name;
  final clint_phone;
  final hight;
  final bttn;
  final cholder;
  final chist_whdth;
  final nick;
  final hand_width;
  final lower_part;
  final hand_length;
  final muscle;

  ClintSizeDetiles(
      {Key key,
      this.clint_name,
      this.clint_phone,
      this.hight,
      this.bttn,
      this.cholder,
      this.chist_whdth,
      this.nick,
      this.hand_width,
      this.lower_part,
      this.hand_length,
      this.muscle})
      : super(key: key);

  @override
  _ClintSizeDetilesState createState() => _ClintSizeDetilesState();
}

class _ClintSizeDetilesState extends State<ClintSizeDetiles> {
  TextEditingController hight = TextEditingController();
  TextEditingController chist = TextEditingController();
  TextEditingController cholder = TextEditingController();
  TextEditingController bttn = TextEditingController();
  TextEditingController lower = TextEditingController();
  TextEditingController nick = TextEditingController();
  TextEditingController arm = TextEditingController();
  TextEditingController muscel = TextEditingController();
  TextEditingController res = TextEditingController();
  String testt;
  var dataright = 0;

// start get dress type

  _confirmData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("تنبيه"),
          content: Container(
            height: 60,
            child: Column(
              children: [
                new Text("هل المقاسات صحيحة ؟"),
                new Text("تأكد من نوع الثوب ونوع القماش"),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("نعم"),
              onPressed: () {
                orderDress();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("الرجاء ادخال رقم القماش واختيار نوع الثوب"),
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

  // final fabricInfo = "https://dressmobile.herokuapp.com/newclint/fabrics";
  final fabricInfo = "http://10.0.2.2:5000/newclint/fabrics";
  List _fabrcList;
  String _fabricType;
  Future _getFabric() async {
    var response = await http.get(fabricInfo);
    var responsbody = jsonDecode(response.body);
    List data = responsbody;
    if (response.statusCode == 200) {
      setState(() {
        _fabrcList = data;
      });
      print(_fabrcList);
    }
  }

// http://10.0.2.2:3000/newclint/dresstype
// https://dressmobile.herokuapp.com/newclint/dresstype
  List _typeList;
  String _dressType;
  Future _getDressType() async {
    var response =
        await http.get("http://10.0.2.2:5000/newclint/dresstype");
    var responsbody = jsonDecode(response.body);
    setState(() {
      _typeList = responsbody;
    });
    print(_typeList);
  }

  void initState() {
    _getDressType();
    _getFabric();
    super.initState();
  }

// end get dress type

// on tap update sizes
//
  upDateSizes() async {
    var emailsherd = UserSimplePrefrences.getEmail();
    var useridshered = UserSimplePrefrences.getId();
    var url = "http://10.0.2.2:5000/newclint/updatesize";
    // var url = "https://dressmobile.herokuapp.com/newclint/updatesize";
    var response = await http.post(
      url,
      body: jsonEncode({
        "userid": useridshered,
        "hight": hight.text == "" ? widget.hight : hight.text,
        "cholder": cholder.text == "" ? widget.cholder : cholder.text,
        "chist": chist.text == "" ? widget.chist_whdth : chist.text,
        "bttn": bttn.text == "" ? widget.bttn : bttn.text,
        "lower": lower.text == "" ? widget.lower_part : lower.text,
        "nick": nick.text == "" ? widget.nick : nick.text,
        "arm": arm.text == "" ? widget.hand_length : arm.text,
        "muscle": muscel.text == "" ? widget.muscle : muscel.text,
        "res": res.text == "" ? widget.hand_width : res.text,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    var responsbody = jsonDecode(response.body);
    if (response.statusCode == 210) {
      setState(() {
        hight.clear();
        cholder.clear();
        chist.clear();
        bttn.clear();
        lower.clear();
        nick.clear();
        arm.clear();
        muscel.clear();
        res.clear();
      });
      print(responsbody);
    } else {
      print("not ok");
    }
  }

// on tap order ress
//
  orderDress() async {
    if (_fabricType != null && _dressType != null) {
      var useridshered = UserSimplePrefrences.getId();
      var usernameshered = UserSimplePrefrences.getUsername();
      var url = "http://10.0.2.2:5000/newclint/ordersress";
      // var url = "https://dressmobile.herokuapp.com/newclint/ordersress";
      var response = await http.post(url,
          body: jsonEncode({
            "userid": useridshered,
            "hight": hight.text == "" ? widget.hight : hight.text,
            "bttn": bttn.text == "" ? widget.bttn : bttn.text,
            "fabricid": _fabricType,
            "dressnum": _dressType,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var responsbody = jsonDecode(response.body);
      print(responsbody);
      if (response.statusCode == 572) {}
    } else {
      _showDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Image(image: AssetImage("assets/take size.jpg")),
            ),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50,
                          width: 130,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, right: 20),
                            child: Text(
                              "اسم الزبون :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50,
                          width: 250,
                          child: Container(
                            margin: EdgeInsets.only(top: 8, right: 20),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.clint_name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50,
                          width: 130,
                          child: Container(
                            margin: EdgeInsets.only(top: 5, right: 20),
                            child: Text(
                              "رقم الهاتف :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: Text(
                              widget.clint_phone.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 2, right: 150),
                      child: Text(
                        "المقاسات",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable("الطول", widget.hight.toString(), ' الطول للتعديل',
                      hight),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('الصدر', widget.chist_whdth.toString(),
                      'ادخل وسع الصدر للتعديل', chist),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('الكتف', widget.cholder.toString(),
                      'من الكتف للكتف', cholder),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('البطن', widget.bttn.toString(),
                      ' ادخل وسع البطن ', bttn),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('اسفل الخصر', widget.lower_part.toString(),
                      'ادخل اسفل الخصر', lower),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable(
                      'الرقبة', widget.nick.toString(), 'ادخل الرقبة ', nick),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable(' الذراع', widget.hand_length.toString(),
                      'ادخل طول الذراع ', arm),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('العضلات', widget.muscle.toString(),
                      'ادخل وسع العضلات', muscel),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  sizeLeable('الرسغ', widget.hand_width.toString(),
                      'ادخل وسع الرسغ', res),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  _typeList != null ? dropDownTypeList(size) : Text("wait"),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  _fabrcList != null ? dropDownFabricList(size) : Text("wait"),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    height: 80,
                    width: 200,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.red)),
                        ),
                      ),
                      onPressed: upDateSizes,
                      child: Text(
                        "تعديل البيانات",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    height: 80,
                    width: 200,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.red)),
                        ),
                      ),
                      onPressed: () {
                        _confirmData(context);
                      },
                      child: Text(
                        "طلب تفصيل",
                        style: TextStyle(fontSize: 25),
                      ),
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

  Container dropDownFabricList(Size size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent.withOpacity(.3),
      ),
      width: size.width / 1.2,
      height: 100,
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                disabledColor: Colors.blueAccent,
                alignedDropdown: true,
                child: DropdownButton<String>(
                        isExpanded: true,
                        focusColor: Colors.blueAccent,
                        dropdownColor: Colors.blueAccent,
                        value: _fabricType,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('اختر نوع القماش'),
                        onChanged: (newValue) {
                          setState(() {
                            _fabricType = newValue;
                          });
                          print(_fabricType);
                        },
                        items: _fabrcList.map((item) {
                          return new DropdownMenuItem(
                            child: Column(
                              children: [
                                Text(
                                    item['fabric_name'] +
                                        " سعر المتر :" +
                                        item['price_per_m'].toString(),
                                    overflow: TextOverflow.visible),
                                Divider(),
                              ],
                            ),
                            value: item['fabric_id'].toString(),
                          );
                        }).toList()) ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container dropDownTypeList(Size size) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent.withOpacity(.3)),
      width: size.width / 1.2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                disabledColor: Colors.blueAccent,
                alignedDropdown: true,
                child: DropdownButton<String>(
                        focusColor: Colors.blueAccent,
                        dropdownColor: Colors.blueAccent,
                        value: _dressType,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('اختر نوع الثوب'),
                        onChanged: (newValue) {
                          setState(() {
                            _dressType = newValue;
                          });
                          print(_dressType);
                        },
                        items: _typeList.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['dress_name']),
                            value: item['dress_id'].toString(),
                          );
                        }).toList()) ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container sizeLeable(String sizetype, String sizevalue, String updatesize,
      TextEditingController mycontrolr) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black54),
            child: Container(
                margin: EdgeInsets.only(right: 10, top: 5),
                child: Text(
                  sizetype,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                )),
          ),
          Padding(padding: EdgeInsets.only(right: 5)),
          Container(
            height: 50,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black54),
            child: Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                child: Text(
                  sizevalue,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                )),
          ),
          Padding(padding: EdgeInsets.only(left: 5)),
          Container(
            height: 50,
            width: 200,
            child: TextField(
              controller: mycontrolr,
              decoration: InputDecoration(
                hintText: updatesize,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownList(Size size, List myList, valueOfString, String textShow,
      String listName, String listId) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent.withOpacity(.3)),
      width: size.width / 1.2,
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                disabledColor: Colors.blueAccent,
                alignedDropdown: true,
                child: DropdownButton<String>(
                        focusColor: Colors.blueAccent,
                        dropdownColor: Colors.blueAccent,
                        value: valueOfString,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text(textShow),
                        onChanged: (newValue) {
                          valueOfString = newValue;

                          print(valueOfString);
                        },
                        items: myList.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item[listName]),
                            value: item[listId].toString(),
                          );
                        }).toList()) ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

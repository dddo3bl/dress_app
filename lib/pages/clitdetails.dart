import 'package:flutter/material.dart';

class ClintDetails extends StatefulWidget {
  final clintname;
  final clintphone;
  final clintid;
  final chistwhdth;
  final chold;
  final hand_whdth;
  final hightall;
  final hightres;
  final kbklength;
  final mfslall;
  final nickall;

  const ClintDetails(
      {
      this.clintname,
      this.clintphone,
      this.clintid,
      this.chistwhdth,
      this.chold,
      this.hand_whdth,
      this.hightall,
      this.hightres,
      this.kbklength,
      this.mfslall,
      this.nickall});
      

  @override
  _ClintDetailsState createState() => _ClintDetailsState();
}

class _ClintDetailsState extends State<ClintDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('بيانات الزبون'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              height: 50,
              color: Colors.blueGrey,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "معلومات الزبون",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  mySpec(context, "اسم الزبون:   ", widget.clintname,
                      Colors.blue, Colors.white),
                  mySpec(context, "رقم الزبون :   ", widget.clintid.toString(),
                      Colors.white, Colors.blue),
                  mySpec(context, " رقم الهاتف:   ",
                      widget.clintphone.toString(), Colors.blue, Colors.white),
                  Container(
                    height: 50,
                    color: Colors.blueGrey,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "المقاسات",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  mySpec(context, 'الطول:   ', widget.hightall.toString(),
                      Colors.white, Colors.blue),
                  mySpec(context, 'وسع الصدر:   ', widget.chistwhdth.toString(),
                      Colors.blue, Colors.white),
                  mySpec(context, 'الكتف:   ', widget.chold.toString(),
                      Colors.white, Colors.blue),
                  mySpec(context, 'وسع اليد:   ', widget.hand_whdth.toString(),
                      Colors.blue, Colors.white),
                  mySpec(context, 'وسع الرسغ:   ', widget.hightres.toString(),
                      Colors.white, Colors.blue),
                  mySpec(context, 'الكبك :   ', widget.kbklength.toString(),
                      Colors.blue, Colors.white),
                  mySpec(context, 'الرقبة:   ', widget.nickall.toString(),
                      Colors.white, Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mySpec(context, String feature, String details, Color colorebackgrund,
    Color colortext) {
  return Container(
    width: MediaQuery.of(context).size.width,
    color: colorebackgrund,
    padding: EdgeInsets.all(10),
    child: RichText(
      text: TextSpan(
          style: TextStyle(fontSize: 19, color: Colors.black),
          children: [
            TextSpan(text: feature),
            TextSpan(
              text: details,
              style: TextStyle(color: colortext),
            )
          ]),
    ),
  );
}

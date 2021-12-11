import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categoryies extends StatefulWidget {
  @override
  _CategoryiesState createState() => _CategoryiesState();
}

class _CategoryiesState extends State<Categoryies> {
  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("الاقمشة"),
            centerTitle: true,
          ),
          body: Card(
            margin: EdgeInsets.only(top: 50, left: 5),
            child: Stack(children: [
              Container(
                height: 100,
                width: 400,
                color: Colors.pinkAccent.withOpacity(.3),
                child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("fabricspage");
                    },
                    child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "الاقمشة",
                            style: TextStyle(fontSize: 30),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 120),
                height: 100,
                width: 400,
                color: Colors.pinkAccent.withOpacity(.3),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("orderpage");
                  },
                  child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "الطلبات",
                          style: TextStyle(fontSize: 30),
                        ),
                      ]),
                ),
              ),
            ]),
          ),
        ));
  }
}

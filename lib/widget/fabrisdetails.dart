import 'package:flutter/material.dart';

class FabricsDeteils extends StatefulWidget {
  final fabric_id;
  final fabric_name;
  final fabric_volor;
  final fabric_price;
  final fabric_tax;

  FabricsDeteils(
      {Key key,
      this.fabric_id,
      this.fabric_name,
      this.fabric_volor,
      this.fabric_price,
      this.fabric_tax})
      : super(key: key);

  @override
  _FabricsDeteilsState createState() => _FabricsDeteilsState();
}

class _FabricsDeteilsState extends State<FabricsDeteils> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          height: 200,
          width: 100,
          color: Colors.blue.withOpacity(.1),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "اسم القماش:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        widget.fabric_name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "رقم القماش:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        widget.fabric_id.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "لون القماش:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        widget.fabric_volor.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "سعر القماش:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        (widget.fabric_price + widget.fabric_tax).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

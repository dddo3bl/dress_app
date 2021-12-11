import 'dart:convert';

import 'package:flutter_app/widget/fabrisdetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FabricsPage extends StatefulWidget {
  @override
  _FabricsPageState createState() => _FabricsPageState();
}

class _FabricsPageState extends State<FabricsPage> {
  fetch_fabr() async {
    http.Response response =
        // "http://10.0.2.2:3000/newclint/fabrics"
        // 'https://dressmobile.herokuapp.com/newclint/fabrics'
        await http.get('http://10.0.2.2:5000/newclint/fabrics');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    }
  }

  void initState() {
    fetch_fabr();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("الاقمشة"),
        ),
        body: FutureBuilder(
          future: fetch_fabr(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return FabricsDeteils(
                      fabric_id: snapshot.data[i]["fabric_id"],
                      fabric_name: snapshot.data[i]["fabric_name"],
                      fabric_price: snapshot.data[i]["price_per_m"],
                      fabric_tax: snapshot.data[i]["tax_amount"],
                      fabric_volor: snapshot.data[i]["color"],
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

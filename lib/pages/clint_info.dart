import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/moduls/storyoneuser.dart';
import 'package:flutter_app/widget/clintsizes.dart';
import 'package:flutter_app/widget/new_clint_size.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'package:http/http.dart' as http;

class Clint_info extends StatefulWidget {
  @override
  _Clint_infoState createState() => _Clint_infoState();
}

class _Clint_infoState extends State<Clint_info> {
  // var email = UserSimplePrefrences.getEmail();

  get_clint_size() async {
    var userid = UserSimplePrefrences.getId();
    var url = "http://10.0.2.2:5000/newclint/clintsize";
    // var url = "https://dressmobile.herokuapp.com/newclint/clintsize";
    var response = await http.post(
      url,
      body: jsonEncode({"userid": userid}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    var responsebody = jsonDecode(response.body);

    List<StoryoneModuel> clint = [];
    for (var one in responsebody) {
      clint.add(StoryoneModuel.fromJson(one));
    }
    print(clint.length);
    return clint;
  }

  @override
  void initState() {
    get_clint_size();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("المقاسات"),
        ),
        body: FutureBuilder(
            future: get_clint_size(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<StoryoneModuel> stories = snapshot.data;
                if (stories.length != 0) {
                  return ListView.builder(
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      return ClintSizeDetiles(
                        clint_name: stories[index].clintname,
                        clint_phone: stories[index].clintphone,
                        hight: stories[index].hight,
                        cholder: stories[index].cholder,
                        chist_whdth: stories[index].chistwhdth,
                        nick: stories[index].nick,
                        hand_width: stories[index].handwhdth,
                        lower_part: stories[index].lowerpart,
                        hand_length: stories[index].handlength,
                        muscle: stories[index].muscle,
                        bttn: stories[index].bttn,
                      );
                    },
                  );
                } else {
                  return NewclintSize();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

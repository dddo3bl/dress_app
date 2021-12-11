import 'package:flutter/material.dart';
import 'package:flutter_app/pages/category.dart';
import 'package:flutter_app/pages/clint_info.dart';
import 'package:flutter_app/pages/fabricspage.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/orderpage.dart';
import 'package:flutter_app/pages/search.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';
import 'accunt.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var email;
  bool isSingin = false;
  var userame;

  getprdf() async {
    userame = UserSimplePrefrences.getUsername();
    email = UserSimplePrefrences.getEmail();

    if (userame != null) {
      userame = UserSimplePrefrences.getUsername();
      email = UserSimplePrefrences.getEmail();
      setState(() {
        userame = UserSimplePrefrences.getUsername();
        email = UserSimplePrefrences.getEmail();
        isSingin = true;
        print(isSingin);
      });
    } else {
      setState(() {
        isSingin = false;
        print(isSingin);
      });
      print("not");
    }
  }

  initState() {
    getprdf();
    super.initState();
  }

  int _currentTap = 0;
  final List<Widget> screen = [
    // falus
    Categoryies(), //0
    Search_for_clint(), //1
    LogIn(), //2
  ];

  final List<Widget> screen2 = [
    // true
    Categoryies(), //0
    Clint_info(), //1
    MyAccunt(), //2
  ];

  void _onItemTap(int index) {
    setState(() {
      _currentTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => Home(),
        'catgory': (context) => Categoryies(),
        'serch': (context) => Search_for_clint(),
        'login': isSingin ? (context) => LogIn() : (context) => MyAccunt(),
        'accunt': (context) => MyAccunt(),
        'fabricspage': (context) => FabricsPage(),
        'orderpage': (context) => OrderPage()
      },
      home: Scaffold(
        body: Center(
          child: isSingin
              ? screen2.elementAt(_currentTap)
              : screen.elementAt(_currentTap),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              title: Text(" الفئات"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              title: isSingin ? Text('المقاسات') : Text("المعلومات"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              title: isSingin ? Text("المعلومات ") : Text("تسجيل الدخول "),
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _currentTap,
          onTap: _onItemTap,
        ),
      ),
    );
  }
}

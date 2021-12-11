import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/widget/usersimpleprefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePrefrences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

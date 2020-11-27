import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/material_white.dart';
import 'package:instagram_flutter/home_page.dart';
// import 'package:flutter/cupertino.dart'; // IOS 디자인

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: white),
    );
  }
}

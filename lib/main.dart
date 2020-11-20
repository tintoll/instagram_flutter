import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/material_white.dart';
import 'package:instagram_flutter/home_page.dart';
import 'package:instagram_flutter/screens/auth_screen.dart'; // 구글 디자인 레이아웃
// import 'package:flutter/cupertino.dart'; // IOS 디자인

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      home: AuthScreen(),
      theme: ThemeData(primarySwatch: white),
    );
  }
}

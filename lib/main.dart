import 'package:flutter/material.dart'; // 구글 디자인 레이아웃
// import 'package:flutter/cupertino.dart'; // IOS 디자인

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(
          title : Text('Cool App')
        ),
        body: Container(color: Colors.amber,),
      )
    );
  }
}

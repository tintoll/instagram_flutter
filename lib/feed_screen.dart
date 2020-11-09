import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'instagram',
            style: TextStyle(
              fontFamily: 'VeganStyle'
            ),
          ),
        ),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index){
        return Container(
          color: Colors.accents[index % Colors.accents.length],
          height: 100,
        );
      }, itemCount: 30,),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: null,
          icon : Icon(
            Icons.camera_alt,
            color: Colors.black87,
          )
        ),
        middle: Text(
            'instagram',
            style: TextStyle(
              fontFamily: 'VeganStyle'
            ),
          ),
          trailing : Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/actionbar_camera.png'),
                    color: Colors.black87,
                  ),
                  onPressed: null
              ),
              IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/actionbar_camera.png'),
                    color: Colors.black87,
                  ),
                  onPressed: null
              ),
            ],
          )
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

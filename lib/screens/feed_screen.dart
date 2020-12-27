import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/repo/user_network_repository.dart';
import 'package:instagram_flutter/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.camera_alt,
                color: Colors.black87,
              )),
          middle: Text(
            'instagram',
            style: TextStyle(fontFamily: 'VeganStyle'),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/actionbar_camera.png'),
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    userNetworkRepository.sendData();
                  }),
              IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/direct_message.png'),
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    userNetworkRepository.getData();
                  }),
            ],
          )),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Post(index);
        },
        itemCount: 30,
      ),
    );
  }
}

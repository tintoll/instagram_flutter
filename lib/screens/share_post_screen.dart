import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/constants/screen_size.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  SharePostScreen(
    this.imageFile, {
    Key key,
    @required this.postKey,
  }) : super(key: key);

  List<String> _tagItems = [
    "서울시",
    "경기도",
    "전라도",
    "경상도",
    "제주도",
    "강원도",
    "충청도",
    "아산",
    "여주",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Post"),
          actions: [
            FlatButton(
                onPressed: () {},
                child: Text(
                  "Share",
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: ListView(
          children: [
            _captionWithImage(),
            _divider,
            _sectionButton('Tag People'),
            _divider,
            _sectionButton('Add Location'),
            Tags(
              horizontalScroll: true,
              itemCount: _tagItems.length,
              heightHorizontalScroll: 30,
              itemBuilder: (index) => ItemTags(
                index: index,
                title: _tagItems[index],
                activeColor: Colors.grey[200],
                textActiveColor: Colors.black87,
                borderRadius: BorderRadius.circular(4),
                elevation: 2,
                color: Colors.green,
              ),
            )
          ],
        ));
  }

  ListTile _sectionButton(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.navigate_next,
        color: Colors.grey[400],
      ),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
    );
  }

  Divider get _divider => Divider(
        color: Colors.grey[300],
        height: 1,
        thickness: 1,
      );

  ListTile _captionWithImage() {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: common_gap, horizontal: common_gap),
      leading: Image.file(
        imageFile,
        width: size.width / 6,
        height: size.width / 6,
        fit: BoxFit.cover,
      ),
      title: TextField(
        decoration: InputDecoration(
            hintText: "Write a caption...", border: InputBorder.none),
      ),
    );
  }
}

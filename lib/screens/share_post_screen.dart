import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/constants/screen_size.dart';
import 'package:instagram_flutter/models/firestore/post_model.dart';
import 'package:instagram_flutter/models/firestore/user_model.dart';
import 'package:instagram_flutter/models/user_model_state.dart';
import 'package:instagram_flutter/repo/image_network_repository.dart';
import 'package:instagram_flutter/repo/post_network_repository.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

class SharePostScreen extends StatefulWidget {
  final File imageFile;
  final String postKey;

  SharePostScreen(
    this.imageFile, {
    Key key,
    @required this.postKey,
  }) : super(key: key);

  @override
  _SharePostScreenState createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  TextEditingController _textEditingController = TextEditingController();

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
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Post"),
          actions: [
            FlatButton(
                onPressed: sharePostProcedure,
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
            _tags(),
            SizedBox(
              height: common_s_gap,
            ),
            _divider,
            SectionSwitch('Facebook'),
            SectionSwitch('Instagrams'),
            SectionSwitch('Tumbler'),
            _divider,
          ],
        ));
  }

  void sharePostProcedure() async {
    // 프로세스 화면 보여주기
    showModalBottomSheet(
        context: context,
        builder: (_) => MyProgressIndicator(),
        isDismissible: false,
        enableDrag: false);

    // 이미지 업로드
    await imageNetworkRepository.uploadImage(widget.imageFile,
        postKey: widget.postKey);

    // Post 생성
    UserModel userModel =
        Provider.of<UserModelState>(context, listen: false).userModel;
    await postNetworkRepository.createNewPost(
        widget.postKey,
        PostModel.getMapForCreatePost(
            userKey: userModel.userKey,
            username: userModel.username,
            caption: _textEditingController.text));
    // Post에 postImg update
    String postImgLink =
        await imageNetworkRepository.getPostImageUrl(widget.postKey);

    await postNetworkRepository.updatePostImgUrl(
        postKey: widget.postKey, postImg: postImgLink);

    // 프로세스 화면 숨기기
    Navigator.of(context).pop();
    // SharePostScreen 나가기
    Navigator.of(context).pop();
  }

  Tags _tags() {
    return Tags(
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
    );
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
        widget.imageFile,
        width: size.width / 6,
        height: size.width / 6,
        fit: BoxFit.cover,
      ),
      title: TextField(
        controller: _textEditingController,
        autofocus: true,
        decoration: InputDecoration(
            hintText: "Write a caption...", border: InputBorder.none),
      ),
    );
  }
}

class SectionSwitch extends StatefulWidget {
  final String _title;

  const SectionSwitch(
    this._title, {
    Key key,
  }) : super(key: key);

  @override
  _SectionSwitchState createState() => _SectionSwitchState();
}

class _SectionSwitchState extends State<SectionSwitch> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget._title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: CupertinoSwitch(
        onChanged: (onValue) {
          setState(() {
            checked = onValue;
          });
        },
        value: checked,
      ),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/constants/screen_size.dart';
import 'package:instagram_flutter/models/firestore/post_model.dart';
import 'package:instagram_flutter/repo/image_network_repository.dart';
import 'package:instagram_flutter/screens/comments_screen.dart';
import 'package:instagram_flutter/widgets/comment.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';
import 'package:instagram_flutter/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final PostModel postModel;

  Post(
    this.postModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(context),
        _postLikes(),
        _postCaption(),
        _lastComment()
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        username: postModel.username,
        text: postModel.caption,
      ),
    );
  }
  Widget _lastComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        username: postModel.lastCommentor,
        text: postModel.lastComment,
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
          '${postModel.numOfLikes == null ? 0 : postModel.numOfLikes.length} likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Row _postActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/bookmark.png'),
              color: Colors.black87,
            ),
            onPressed: null),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/comment.png'),
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return CommentsScreen();
              }));
            }),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/direct_message.png'),
              color: Colors.black87,
            ),
            onPressed: null),
        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/heart_selected.png'),
              color: Colors.black87,
            ),
            onPressed: null),
      ],
    );
  }

  Row _postHeader() {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(common_xxs_gap),
            child: RoundedAvatar()),
        Expanded(child: Text(postModel.username)),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black87,
            ),
            onPressed: null)
      ],
    );
  }

  Widget _postImage() {
    var myProgressIndicator = MyProgressIndicator(
      containerSize: size.width,
    );

    return CachedNetworkImage(
      placeholder: (BuildContext context, String url) {
        return myProgressIndicator;
      },
      imageUrl: postModel.postImg,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}

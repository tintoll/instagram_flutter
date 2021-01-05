import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/constants/screen_size.dart';
import 'package:instagram_flutter/repo/image_network_repository.dart';
import 'package:instagram_flutter/widgets/comment.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';
import 'package:instagram_flutter/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        username: 'testingUser',
        text: 'I have a lot of money!!',
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
          '12000 likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Row _postActions() {
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
            onPressed: null),
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
        Expanded(child: Text('username')),
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
    return FutureBuilder<String>(
      future: imageNetworkRepository.getPostImageUrl("1609879337596444_ecfJx67Eo2Uz62zN4Ok0lTjbhZo1"),
      builder: (context, snapshot) {
        var myProgressIndicator = MyProgressIndicator(
          containerSize: size.width,
        );
        if(snapshot.hasData) {
          return CachedNetworkImage(
            placeholder: (BuildContext context, String url) {
              return myProgressIndicator;
            },
            imageUrl: snapshot.data.toString(),
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
        } else {
          return myProgressIndicator;
        }

      }
    );
  }
}

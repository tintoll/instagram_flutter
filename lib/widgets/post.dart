import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return CachedNetworkImage(
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(containerSize: size.width,);
      },
      imageUrl: 'https://picsum.photos/id/$index/1000/1000',
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

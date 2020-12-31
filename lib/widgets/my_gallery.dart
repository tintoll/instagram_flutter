import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/gallery_state.dart';
import 'package:instagram_flutter/models/user_model_state.dart';
import 'package:instagram_flutter/repo/helper/generate_post_key.dart';
import 'package:instagram_flutter/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImages(context, galleryState),
        );
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    return galleryState.images
        .map(
          (localImage) => InkWell(
              onTap: () async {
                // localImage를 바로 File 만들수 없기 때문에 byte로 변경했다가 File로 만들어준다.
                Uint8List bytes = await localImage.getScaledImageBytes(
                    galleryState.localImageProvider, 0.3);

                final postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);
                try {
                  final path = join(
                      (await getTemporaryDirectory()).path, '$postKey.png');
                  File imageFile = File(path)..writeAsBytesSync(bytes);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SharePostScreen(imageFile, postKey: postKey,)));
                } catch (e) {}
              },
              child: Image(
                image: DeviceImage(localImage, scale: 0.1),
                fit: BoxFit.cover,
              )),
        )
        .toList();
  }
}

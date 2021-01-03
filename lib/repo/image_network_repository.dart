import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:instagram_flutter/repo/helper/image_helper.dart';

class ImageNetworkRepository {
  Future<void> uploadImageNCreateNewPost(File originImage) async {
    try {
      // 이미지 리사이즈 시간이 많이 소요되기 때문에
      // main thread가 아닌 isolate thread에서 작업을 위임하는게 compute 이다.
      final resizedImage = await compute(getResizedImage, originImage);
      originImage.length().then((value) => print('origin image size : $value'));
      resizedImage
          .length()
          .then((value) => print('resized image size : $value'));

      Future.delayed(Duration(seconds: 3));
    } catch (e) {}
  }
}


ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
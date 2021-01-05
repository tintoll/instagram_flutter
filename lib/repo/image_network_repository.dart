import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_flutter/repo/helper/image_helper.dart';

class ImageNetworkRepository {
  Future<TaskSnapshot> uploadImageNCreateNewPost(File originImage, {@required postKey}) async {
    try {
      // 이미지 리사이즈 시간이 많이 소요되기 때문에
      // main thread가 아닌 isolate thread에서 작업을 위임하는게 compute 이다.
      final resizedImage = await compute(getResizedImage, originImage);
      final Reference ref =FirebaseStorage.instance.ref().child(_getImagePathByPostKey(postKey));
      final UploadTask uploadTask = ref.putFile(resizedImage);
      return Future.value(uploadTask.snapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';
}


ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
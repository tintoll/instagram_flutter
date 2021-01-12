import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/constants/firestore_keys.dart';
import 'package:instagram_flutter/models/firestore/post_model.dart';
import 'package:instagram_flutter/repo/helper/transformers.dart';
import 'package:rxdart/rxdart.dart';

class PostNetworkRepository with Transformers {
  Future<Map<String, dynamic>> createNewPost(
      String postKey, Map<String, dynamic> postData) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(postData[KEY_USERKEY]);

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (!postSnapshot.exists) {
        await tx.set(postRef, postData);
        await tx.update(userRef, {
          KEY_MYPOSTS: FieldValue.arrayUnion([postKey])
        });
      }
    });
  }

  Future<void> updatePostImgUrl({String postImg, String postKey}) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();
    if (postSnapshot.exists) {
      postRef.update({KEY_POSTIMG: postImg});
    }
  }

  Stream<List<PostModel>> getPostsFromSpecificUser(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .where(KEY_USERKEY, isEqualTo: userKey)
        .snapshots()
        .transform(toPosts);
  }

  Stream<List<PostModel>> fetchPostsFromAllFollowings(List<dynamic> followings) {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS);
    List<Stream<List<PostModel>>> streams = [];

    for (final following in followings) {
      streams.add(collectionReference
          .where(KEY_USERKEY, isEqualTo: following)
          .snapshots()
          .transform(toPosts));
    }

    return CombineLatestStream.list<List<PostModel>>(streams).transform(combineListOfPosts);
  }
}

PostNetworkRepository postNetworkRepository = PostNetworkRepository();

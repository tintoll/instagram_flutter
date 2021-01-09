import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/constants/firestore_keys.dart';
import 'package:instagram_flutter/models/firestore/user_model.dart';
import 'package:instagram_flutter/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection(CONLLECTION_USERS).doc(userKey);
    DocumentSnapshot documentSnapshot = await docRef.get();
    if (!documentSnapshot.exists) {
      return await docRef.set(UserModel.getMapForCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance
        .collection(CONLLECTION_USERS)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }

  Stream<List<UserModel>> getAllUsersWithoutMe() {
    return FirebaseFirestore.instance
        .collection(CONLLECTION_USERS)
        .snapshots()
        .transform(toUsersExceptMe);
  }

  Future<void> followerUser({String myUserKey, String otherUserKey}) async {
    // 나의 정보 가져오기
    final DocumentReference myUserRef =
        FirebaseFirestore.instance.collection(CONLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    // 팔로우할 상대방 정보 가져오기
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(CONLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {KEY_FOLLOWINGS: FieldValue.arrayUnion([otherUserKey])});
        int currentFollowers = otherSnapshot.get(KEY_FOLLOWERS);
        tx.update(otherUserRef, {KEY_FOLLOWERS: currentFollowers+1});
      }
    });
  }
  Future<void> unFollowerUser({String myUserKey, String otherUserKey}) async {
    // 나의 정보 가져오기
    final DocumentReference myUserRef =
    FirebaseFirestore.instance.collection(CONLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    // 팔로우할 상대방 정보 가져오기
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(CONLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {KEY_FOLLOWINGS: FieldValue.arrayRemove([otherUserKey])});
        int currentFollowers = otherSnapshot.get(KEY_FOLLOWERS);
        tx.update(otherUserRef, {KEY_FOLLOWERS: currentFollowers-1});
      }
    });
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();

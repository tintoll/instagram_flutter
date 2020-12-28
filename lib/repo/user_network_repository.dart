import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/constants/firestore_keys.dart';
import 'package:instagram_flutter/models/firestore/user_model.dart';

class UserNetworkRepository {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection(CONLLECTION_USERS).doc(userKey);
    DocumentSnapshot documentSnapshot = await docRef.get();
    if (!documentSnapshot.exists) {
      return await docRef.set(UserModel.getMapForCreateUser(email));
    }
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();

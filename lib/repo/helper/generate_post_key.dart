import 'package:instagram_flutter/models/firestore/user_model.dart';

String getNewPostKey(UserModel userModel) =>
    "${DateTime.now().microsecondsSinceEpoch}_${userModel.userKey}";

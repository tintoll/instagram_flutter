import 'package:cloud_firestore/cloud_firestore.dart';

class UserNetworkRepository {
  Future<void> sendData() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc('123123123')
        .set({'email': 'test@test.com', 'username': 'teset1'});
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc('123123123')
        .get()
        .then((docuSnapshot) => print(docuSnapshot.data()));
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
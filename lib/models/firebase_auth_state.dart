import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  User _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null && _firebaseUser == null) {
        return;
      } else if(user != _firebaseUser){
        _firebaseUser = user;
        changeFirebaseStatus();
      }
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if(_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }

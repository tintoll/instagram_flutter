import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  void registerUser(BuildContext context, {@required String email, @required String password}) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
         print(error.code);
         String _message = "";
         switch(error.code) {
           case "email-already-in-use" :
             _message = error.message;
             break;
           case "invalid-email" :
             _message = error.message;
             break;
           case "operation-not-allowed" :
             _message = error.message;
             break;
           case "weak-password" :
             _message = error.message;
             break;
         }
         SnackBar snackBar = SnackBar(content: Text(_message));
         return Scaffold.of(context).showSnackBar(snackBar);
    });
  }
  void login({@required String email, @required String password}) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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

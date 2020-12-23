import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:instagram_flutter/utils/simple_snackbar.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  User _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin;
  bool initiated = false;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null && _firebaseUser == null) {
        if (initiated)
          changeFirebaseStatus();
        else
          initiated = true;
        return;
      } else if (user != _firebaseUser) {
        _firebaseUser = user;
        changeFirebaseStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) {
    changeFirebaseStatus(FirebaseAuthStatus.progress);
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      String _message = "";
      switch (error.code) {
        case "email-already-in-use":
          _message = error.message;
          break;
        case "invalid-email":
          _message = error.message;
          break;
        case "operation-not-allowed":
          _message = error.message;
          break;
        case "weak-password":
          _message = error.message;
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message));
      // Scaffold 아래 있는 context를 가져와야된다.
      return Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void login(BuildContext context,
      {@required String email, @required String password}) {
    changeFirebaseStatus(FirebaseAuthStatus.progress);
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      String _message = "";
      switch (error.code) {
        case "invalid-email":
          _message = "잘못된 이메일주소인데";
          break;
        case "user-disabled":
          _message = "해당사용자 금지";
          break;
        case "user-not-found":
          _message = "사용자가 없는데";
          break;
        case "wrong-password":
          _message = "잘못된 비밀번호인데";
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message));
      // Scaffold 아래 있는 context를 가져와야된다.
      return Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() async {
    changeFirebaseStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      if (await _facebookLogin.isLoggedIn) await _facebookLogin.logOut();
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

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseStatus(FirebaseAuthStatus.progress);
    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(context, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackbar(context, 'cancelledByUser');
        break;
      case FacebookLoginStatus.error:
        simpleSnackbar(context, 'error');
        _facebookLogin.logOut();
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    final AuthCredential authCredential =
        FacebookAuthProvider.credential(token);
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);
    final User user = userCredential.user;
    if (user == null) {
      simpleSnackbar(context, '페북 로그인 실패');
    } else {
      _firebaseUser = user;
    }

    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }

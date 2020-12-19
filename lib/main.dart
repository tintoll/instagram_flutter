import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/material_white.dart';
import 'package:instagram_flutter/home_page.dart';
import 'package:instagram_flutter/models/firebase_auth_state.dart';
import 'package:instagram_flutter/screens/auth_screen.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/cupertino.dart'; // IOS 디자인

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        home: Consumer(
            builder: (BuildContext context, FirebaseAuthState firebaseAuthState,
                Widget child) {
              switch (firebaseAuthState.firebaseAuthStatus) {
                case FirebaseAuthStatus.signout:
                  return AuthScreen();
                case FirebaseAuthStatus.progress:
                  return MyProgressIndicator();
                case FirebaseAuthStatus.signin:
                  return HomePage();
                default:
                  return MyProgressIndicator();
              }
            },
        ),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }
}

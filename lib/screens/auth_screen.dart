import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';
import 'package:instagram_flutter/widgets/sign_up_form.dart';
import 'package:instagram_flutter/widgets/sing_in_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Widget signInForm = SignInForm();
  Widget signUpForm = SignUpForm();

  Widget currentWidget;

  @override
  void initState() {
    if (currentWidget == null) currentWidget = signUpForm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: duration,
              child: currentWidget,
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if(currentWidget is SignUpForm) {
                      currentWidget = signInForm;
                    } else {
                      currentWidget = signUpForm;
                    }
                  });
                },
                child: Text('go to sing up form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

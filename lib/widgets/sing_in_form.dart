import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/auth_input_decor.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/home_page.dart';
import 'package:instagram_flutter/models/firebase_auth_state.dart';
import 'package:instagram_flutter/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: texInputDecor("Email"),
                validator: (text) {
                  if (text.isNotEmpty && text.contains('@')) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력하여 주세요';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                obscureText: true,
                cursorColor: Colors.black54,
                decoration: texInputDecor("Password"),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return '패스워드를 5자리 이상 입력하여 주세요';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              FlatButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Fogotten Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                onPressed: () {
                  Provider.of<FirebaseAuthState>(context, listen: false)
                      .changeFirebaseStatus(FirebaseAuthStatus.signin);
                },
                textColor: Colors.blue,
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                label: Text("Login with Facebook"),
              )
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Provider.of<FirebaseAuthState>(context, listen: false)
              .login(context, email: _emailController.text, password: _pwController.text);
        }
      },
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _editingController = new TextEditingController();
  TextEditingController _pwController = new TextEditingController();
  TextEditingController _cpwController = new TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              controller: _editingController,
              cursorColor: Colors.black54,
              decoration: _texInputDecor("Email"),
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
              decoration: _texInputDecor("Password"),
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
            TextFormField(
              controller: _cpwController,
              obscureText: true,
              cursorColor: Colors.black54,
              decoration: _texInputDecor("Confirm Password"),
              validator: (text) {
                if (text.isNotEmpty && _pwController.text == text) {
                  return null;
                } else {
                  return '패스워드와 일치 하지 않습니다. 다시 입력하여 주세요';
                }
              },
            ),
            SizedBox(
              height: common_s_gap,
            ),
            FlatButton(
              onPressed: () {
                if(_formKey.currentState.validate()) {
                  print('validator success');
                }
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Join',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _texInputDecor(hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        filled: true,
        fillColor: Colors.grey[100]);
  }
}

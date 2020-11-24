import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _editingController = new TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
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
              decoration: InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(common_s_gap),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100]),
              validator: (text) {
                if (text.isNotEmpty && text.contains('@')) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력하여 주세요';
                }
              },
            ),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}

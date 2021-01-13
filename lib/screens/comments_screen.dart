import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.amber,
            )),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: common_gap),
                    child: TextFormField(
                      controller: _textEditingController,
                      cursorColor: Colors.black54,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Input Something";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        // todo : createNewComment
                      }
                    },
                    child: Text('Post'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

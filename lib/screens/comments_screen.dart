import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/models/firestore/comment_model.dart';
import 'package:instagram_flutter/models/firestore/user_model.dart';
import 'package:instagram_flutter/models/user_model_state.dart';
import 'package:instagram_flutter/repo/comment_network_repository.dart';
import 'package:instagram_flutter/widgets/comment.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final String postKey;

  const CommentsScreen(this.postKey, {
    Key key,
  }) : super(key: key);

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
              child: StreamProvider<List<CommentModel>>.value(
                value:
                commentNetworkRepository.fetchAllComments(widget.postKey),
                child: Consumer<List<CommentModel>>(builder:
                    (BuildContext context, List<CommentModel> comments,
                    Widget child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Comment(
                        username: comments[index].username,
                        text: comments[index].comment,
                        dateTime: comments[index].commentTime,
                        showImage: true,);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: common_s_gap,);
                    },
                    itemCount: comments == null ? 0 : comments.length,
                  );
                }),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
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
                    onPressed: () async {
                      if (_globalKey.currentState.validate()) {
                        // todo : createNewComment
                        UserModel userModel =
                            Provider
                                .of<UserModelState>(context, listen: false)
                                .userModel;
                        Map<String, dynamic> newComment =
                        CommentModel.getMapForNewComment(
                            userModel.userKey,
                            userModel.username,
                            _textEditingController.text);
                        await commentNetworkRepository.createNewComment(
                            widget.postKey, newComment);
                        _textEditingController.clear();
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

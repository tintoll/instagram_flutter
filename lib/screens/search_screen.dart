import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/firestore/user_model.dart';
import 'package:instagram_flutter/models/user_model_state.dart';
import 'package:instagram_flutter/repo/user_network_repository.dart';
import 'package:instagram_flutter/widgets/my_progress_indicator.dart';
import 'package:instagram_flutter/widgets/rounded_avatar.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Followers/Followings')),
      body: StreamBuilder<List<UserModel>>(
          stream: userNetworkRepository.getAllUsersWithoutMe(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(child: Consumer<UserModelState>(
                builder: (BuildContext context, UserModelState myUserModelState,
                    Widget child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      UserModel otherUserModel = snapshot.data[index];
                      bool amIFollowing = myUserModelState
                          .amIFollowings(otherUserModel.userKey);
                      return ListTile(
                        onTap: () {
                          setState(() {
                            amIFollowing
                                ? userNetworkRepository.unFollowerUser(
                                    myUserKey:
                                        myUserModelState.userModel.userKey,
                                    otherUserKey: otherUserModel.userKey)
                                : userNetworkRepository.followerUser(
                                    myUserKey:
                                        myUserModelState.userModel.userKey,
                                    otherUserKey: otherUserModel.userKey);
                          });
                        },
                        leading: RoundedAvatar(),
                        title: Text(otherUserModel.username),
                        subtitle:
                            Text('user bio number  ${otherUserModel.username}'),
                        trailing: Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: amIFollowing
                                  ? Colors.blue[50]
                                  : Colors.red[50],
                              border: Border.all(
                                  color:
                                      amIFollowing ? Colors.blue : Colors.red,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: FittedBox(
                            child: Text(
                                amIFollowing ? 'following' : 'not following',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey,
                        height: 1,
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                },
              ));
            } else {
              return MyProgressIndicator();
            }
          }),
    );
  }
}

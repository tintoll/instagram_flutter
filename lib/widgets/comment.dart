import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/widgets/rounded_avatar.dart';

class Comment extends StatelessWidget {

  final bool showImage;
  final String userName;
  final String text;
  final DateTime dateTime;

  const Comment({
    Key key, this.showImage = false, @required this.userName,  @required this.text, this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(showImage)
          RoundedAvatar(size: 24,),
        if(showImage)
          SizedBox(
            width: common_xxs_gap,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: userName,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      TextSpan(text: '   '),
                      TextSpan(
                          text: text,
                          style: TextStyle(
                            color: Colors.black87,
                          )
                      ),
                    ]
                )
            ),
            if(dateTime != null)
              Text(
                dateTime.toIso8601String(),
                style: TextStyle(
                  color: Colors.grey[400]
              ),)
          ],
        ),
      ],
    );
  }
}
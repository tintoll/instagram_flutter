import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/common_size.dart';
import 'package:instagram_flutter/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.width,
          color: Colors.black,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(common_gap),
            child: OutlineButton(
              shape: CircleBorder(),
              onPressed: () {},
              borderSide: BorderSide(
                width: 20,
                color: Colors.black12
              ),
            ),
          ),
        ),
      ],
    );
  }
}

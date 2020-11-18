import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/screen_size.dart';
import 'package:instagram_flutter/widgets/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = size.width / 2;
  final duration = Duration(milliseconds: 300);

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXPos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: ProfileBody(
              onMenuChanged: () {
                setState(() {
                  _menuStatus = (_menuStatus == MenuStatus.closed) ? MenuStatus.opened : MenuStatus.closed;
                  switch(_menuStatus) {
                    case MenuStatus.opened:
                      bodyXPos = -menuWidth;
                      menuXPos = size.width - menuWidth;
                      break;
                    case MenuStatus.closed:
                      bodyXPos = 0;
                      menuXPos = size.width;
                      break;
                  }
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(menuXPos, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: Positioned(
                width: menuWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  color: Colors.purpleAccent,
                )),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }

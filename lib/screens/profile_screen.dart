import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [_appBar()],
          ),
        ));
  }

  Row _appBar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
          child: Text(
            'The coding papa',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        )
      ],
    );
  }
}

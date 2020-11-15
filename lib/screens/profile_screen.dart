import 'package:flutter/material.dart';
import 'package:instagram_flutter/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appbar(),
              ProfileBody()
            ],
          ),
        ));
  }



  Row _appbar() {
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

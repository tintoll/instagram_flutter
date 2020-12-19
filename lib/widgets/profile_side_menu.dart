import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/firebase_auth_state.dart';
import 'package:provider/provider.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  const ProfileSideMenu(
    this.menuWidth, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => AuthScreen(),
                //   ),
                // );
                Provider.of<FirebaseAuthState>(context, listen: false).changeFirebaseStatus(FirebaseAuthStatus.signout);
              },
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              title: Text(
                'Sign out',
              ),
            )
          ],
        ),
      ),
    );
  }
}

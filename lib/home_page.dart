
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/constants/screen_size.dart';
import 'package:instagram_flutter/screens/camera_screen.dart';
import 'package:instagram_flutter/screens/feed_screen.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.purpleAccent,
    ),
    Container(
      color: Colors.cyanAccent,
    ),
    ProfileScreen()
  ];

  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // 초기화
    if (size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onBtmItemClick,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onBtmItemClick(int index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        {
          print(index);
          setState(() {
            _selectedIndex = index;
          });
        }
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context))
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackBar = SnackBar(
        content: Text("카메라, 마이크 권한을 허용해주세요"),
        action: SnackBarAction(
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
          label: 'OK',
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  // 카메라 및 마이크 권한을 확인 한다.
  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();

    bool permitted = true;
    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}

import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.cyanAccent,
          ),
          Container(
            color: Colors.redAccent,
          ),
          Container(
            color: Colors.greenAccent,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked),
            label: "GALLAY",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked),
            label: "PHOTO",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked),
            label: "VIDEO",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTabbed,
      ),
    );
  }

  void _onItemTabbed(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

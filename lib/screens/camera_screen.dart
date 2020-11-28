import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
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
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}

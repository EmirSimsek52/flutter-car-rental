import 'package:flutter/material.dart';

import '../Screens/home.dart';
import '../Screens/cars.dart';
import '../Screens/admin.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Home(),
    Cars(),
    Admin(),
  ];

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              setState(() {
                _currentIndex = value;
              });
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/1.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Home',
                  activeIcon: Image.asset(
                    'assets/icons/1.2.png',
                    height: myHeight * 0.03,
                    color: _currentIndex == 0 ? Color(0xFF9C27B0) : Colors.grey,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/6.2.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Cars',
                  activeIcon: Image.asset(
                    'assets/icons/6.2.png',
                    height: myHeight * 0.03,
                    color: _currentIndex == 1 ? Color(0xFF9C27B0) : Colors.grey,
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/4.1.png',
                    height: myHeight * 0.03,
                    color: Colors.grey,
                  ),
                  label: 'Admin',
                  activeIcon: Image.asset(
                    'assets/icons/4.2.png',
                    height: myHeight * 0.03,
                    color: _currentIndex == 2 ? Color(0xFF9C27B0) : Colors.grey,
                  )),
            ]),
      ),
    );
  }
}

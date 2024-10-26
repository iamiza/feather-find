import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:featherfind/screens/homepage.dart';
import 'package:featherfind/screens/mappage.dart';
import 'package:featherfind/screens/profilepage.dart';
import 'package:featherfind/screens/recordingpage.dart';
import 'package:featherfind/screens/settingpage.dart';
import 'package:flutter/material.dart';

List<IconData> iconList = [
  Icons.home,
  Icons.pin_drop,
  Icons.person,
  Icons.settings
];

List<String> labelList = ["Home", "Map", "Profile", "Settings"];
int _bottomNavIndex = 0;

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<Widget> _pages = [
    const Homepage(),
    const Mappage(),
    const Profilepage(),
    const Settingpage(),
    const Recordingpage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          setState(() {
            if (mounted) {
              _bottomNavIndex = 4;
            }
          });
        },
        child: Image.asset("assets/images/logo.png"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive ? const Color.fromARGB(255, 27, 95, 150) : Colors.grey;
          return Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              Text(
                labelList[index],
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              )
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        onTap: (index) {
          if (mounted) {
            setState(() {
              _bottomNavIndex = index;
            });
          }
        },
        gapLocation: GapLocation.center,
        notchMargin: 5,
        elevation: 0,
      ),
    );
  }
}

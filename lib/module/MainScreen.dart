import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/MainScreenNotifier.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainScreenNotifier viewModel = Provider.of<MainScreenNotifier>(context);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          GetScreen("Home"),
          GetScreen("Search"),
          GetScreen("Uplaod Videos"),
          GetScreen("Message"),
          GetScreen("Profile")
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        items: [
          getBottomNavigationBarItem(
              Icon(
                Icons.home,
                size: 30.0,
              ),
              "Home"),
          getBottomNavigationBarItem(
              Icon(
                FeatherIcons.search,
                size: 30.0,
              ),
              "Search"),
          getBottomNavigationBarItem(tiktokIcon(context), ""),
          getBottomNavigationBarItem(
              Icon(
                FeatherIcons.messageSquare,
                size: 30.0,
              ),
              "Message"),
          getBottomNavigationBarItem(
              Icon(
                FeatherIcons.user,
                size: 30.0,
              ),
              "Me")
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void _onPageChanged(int _page) {
    setState(() {
      this._page = _page;
    });
  }

  BottomNavigationBarItem getBottomNavigationBarItem(
      Widget icon, String label) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }

  tiktokIcon(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30.0,
        width: 50.0,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.0),
              width: 38.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              width: 38.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: 38.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.add,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  Widget GetScreen(String title) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text(title),
          onPressed: () {},
        ),
      ),
    );
  }
}

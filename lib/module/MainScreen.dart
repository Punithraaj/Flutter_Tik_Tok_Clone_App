import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuthService auth = FirebaseAuthService();
  late PageController _pageController;
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          GetScreen("Home"),
          GetScreen("Search"),
          GetScreen("UploadVideo"),
          GetScreen("Message"),
          GetScreen("Profile"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Theme.of(context).textTheme.headline6?.color,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.search,
              size: 30.0,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: tiktokIcon(context),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.messageSquare,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.user,
            ),
            label: "",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
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
                borderRadius: BorderRadius.circular(7.0),
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget GetScreen(String title) {
    return Scaffold(
        body: Center(
            child: TextButton(
      child: Text(title),
      onPressed: () {},
    )));
  }
}

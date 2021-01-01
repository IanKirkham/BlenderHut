import 'package:flutter/material.dart';
import 'screens/fill/fill.dart';
import 'screens/home/home.dart';
import 'screens/profile/profile.dart';
import 'screens/recipe_list/recipe_list.dart';

class App extends StatefulWidget {
  GlobalKey navBarGlobalKey;
  App(this.navBarGlobalKey);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  final tabs = [
    Home(),
    RecipeList(),
    Fill(),
    Profile(),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home:
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: widget.navBarGlobalKey,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_module),
            label: 'All Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart),
            label: 'Fill Containers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
              //pageController.jumpToPage(index);
            },
          );
        },
      ),
    );
  }
}

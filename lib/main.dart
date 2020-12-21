import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/recipes/recipes.dart';
import 'screens/fill/fill.dart';
import 'screens/profile/profile.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  final tabs = [
    Home(),
    Recipes(),
    Fill(),
    Profile(),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.view_module),
                label: 'All Recipes',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.addchart),
                label: 'Fill Cansiters',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                //pageController.animateToPage(index,
                //duration: Duration(milliseconds: 500), curve: Curves.ease);
                pageController.jumpToPage(index);
              });
            }),
      ),
      theme: _theme(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.blueGrey[900],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

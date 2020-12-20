import 'package:flutter/material.dart';
import 'home/home.dart';
import 'recipes/recipes.dart';
import 'fill/fill.dart';
import 'profile/profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: tabs[_currentIndex],
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
              });
            }),
      ),
      theme: _theme(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.cyanAccent[400],
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

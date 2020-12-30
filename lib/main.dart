import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/recipes/recipes.dart';
import 'screens/fill/fill.dart';
import 'screens/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
}

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

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
            key: navBarGlobalKey,
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
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                //pageController.jumpToPage(index);
              });
            }),
      ),
      theme: _theme(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlueAccent,
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xFF1F2C34), //Colors.blueGrey[900],
        elevation: 0,
      ),
      textTheme: TextTheme(
          headline3: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 40,
          ),
          headline4: GoogleFonts.montserrat(
            color: Colors.white,
          ),
          bodyText2: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
          )),
      scaffoldBackgroundColor: Color(0xFF1F2C34), //Colors.blueGrey[900],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF2F3D46), //Colors.blueGrey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF788388), //Colors.blueGrey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}

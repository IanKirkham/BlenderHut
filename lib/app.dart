import 'package:blenderapp/widgets/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/fill/fill.dart';
import 'screens/home/home.dart';
import 'screens/profile/profile.dart';
import 'screens/recipe_list/recipe_list.dart';

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<TabItem> tabItems = [
    TabItem(
      title: 'Home',
      iconData: Icons.home,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: Home(),
    ),
    TabItem(
      title: 'All Recipes',
      iconData: Icons.view_module,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: RecipeList(),
    ),
    TabItem(
      title: 'Fill Containers',
      iconData: Icons.addchart,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: Fill(),
    ),
    TabItem(
      title: 'Profile',
      iconData: Icons.person,
      navigatorKey: GlobalKey<NavigatorState>(),
      page: Profile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentTab = tabItems[_currentIndex];
    return WillPopScope(
      onWillPop: () async =>
          !await currentTab.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: tabItems
              .map(
                _buildIndexedPageFlow,
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: navBarGlobalKey,
          currentIndex: _currentIndex,
          items: tabItems
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.title,
                  icon: Icon(item.iconData),
                ),
              )
              .toList(),
          onTap: (newIndex) {
            setState(
              () {
                if (_currentIndex != newIndex) {
                  _currentIndex = newIndex;
                } else {
                  currentTab.navigatorKey.currentState
                      .popUntil((route) => route.isFirst);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndexedPageFlow(TabItem tabItem) => Navigator(
        key: tabItem.navigatorKey,
        onGenerateRoute: (settings) => CupertinoPageRoute(
          settings: settings,
          builder: (context) => tabItem.page,
        ),
      );
}

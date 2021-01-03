import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget page;

  TabItem({
    @required this.title,
    @required this.iconData,
    @required this.navigatorKey,
    @required this.page,
  });
}

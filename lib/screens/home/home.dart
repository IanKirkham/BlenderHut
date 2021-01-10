import 'package:blenderapp/app.dart';
import 'package:blenderapp/widgets/horizontalBarLabelChart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                final BottomNavigationBar navBar =
                    navBarGlobalKey.currentWidget;
                navBar.onTap(2);
              },
              //child: ContainerGraph(null),
              child: HorizontalBarLabelChart(null),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                MyCustomCarosel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomCarosel extends StatefulWidget {
  @override
  _MyCustomCaroselState createState() => _MyCustomCaroselState();
}

class _MyCustomCaroselState extends State<MyCustomCarosel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.8,
            initialPage: 0,
            pageViewKey: PageStorageKey<String>('carousel_slider'),
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: getFavorites(context),
        ),
        Center(
          child: DotsIndicator(
            dotsCount: 5,
            position: _current.toDouble(),
            decorator: DotsDecorator(
              activeColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// make this dynamic by getting recipe objects from API, list of Recipe view widgets?
List<Widget> getFavorites(context) {
  List<Widget> list = [];

  // list.add(
  //   Container(
  //     width: MediaQuery.of(context).size.width / 2,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Text(
  //           "No favorites found",
  //           style: Theme.of(context).textTheme.bodyText2,
  //           textAlign: TextAlign.center,
  //         ),
  //         Icon(
  //           Icons.add,
  //           size: MediaQuery.of(context).size.width / 4,
  //           color: Colors.white,
  //         ),
  //         Text(
  //           "Tap to add some favorites now!",
  //           style: Theme.of(context).textTheme.bodyText2,
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       color: Color(0xFF2F3D46), //Colors.blueGrey[700].withOpacity(0.5),
  //     ),
  //   ),
  //   //),
  // );
  // return list;

  for (int i = 0; i < 5; i++) {
    list.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Color(0xFF2F3D46),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Text(
                'Favorite #' + (i + 1).toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Secondary Text',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Blah Blah Blah Blah Blah Blah Blah',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return list;
}

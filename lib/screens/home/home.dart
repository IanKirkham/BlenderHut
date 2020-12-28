import 'package:blenderapp/widgets/canisterGraph.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
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
                    //final snackBar =
                    //  SnackBar(content: Text("Clicked the Container!"));

                    //Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: CanisterGraph(null),
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
                    CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 0.8,
                        initialPage: 0,
                        pageViewKey: PageStorageKey<String>('carousel_slider'),
                        enableInfiniteScroll: false,
                      ),
                      items: getFavorites(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: make this dynamic by getting recipe objects from API, list of Recipe view widgets?
List<Widget> getFavorites(context) {
  List<Widget> list = [];

  // Fetch data from API

  if (false) {
    list.add(
      GestureDetector(
        onTap: () {
          final BottomNavigationBar navBar = navBarGlobalKey.currentWidget;
          navBar.onTap(1);
          //final snackBar =
          //  SnackBar(content: Text("Clicked the Container!"));

          //Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "No favorites found",
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              Icon(
                Icons.add,
                size: MediaQuery.of(context).size.width / 4,
                color: Colors.white,
              ),
              Text(
                "Tap to add some favorites now!",
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.blueGrey[700].withOpacity(0.5),
          ),
        ),
      ),
    );
    return list;
  }

  for (int i = 0; i < 5; i++) {
    list.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
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
                  'Here is some words here or something...',
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

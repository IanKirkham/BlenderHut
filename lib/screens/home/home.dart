import 'package:blenderapp/widgets/canisterGraph.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CanisterGraph(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      initialPage: 0,
                      pageViewKey: PageStorageKey<String>('carousel_slider'),
                      enableInfiniteScroll: false,
                    ),
                    items: getFavorites(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: make this dynamic by getting recipe objects from API, list of Recipe view widgets?
List<Widget> getFavorites() {
  List<Widget> list = [];

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
              ListTile(
                title: Text('Favorite #' + (i + 1).toString()),
                subtitle: Text(
                  'Secondary Text',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Here is some words here or something...',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
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

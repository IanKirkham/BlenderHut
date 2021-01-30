import 'package:blenderapp/main.dart';
import 'package:blenderapp/models/containerData.dart';
import 'package:blenderapp/models/ingredient.dart';
import 'package:blenderapp/models/recipe.dart';
import 'package:blenderapp/widgets/horizontalBarLabelChart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../apiService.dart';
import 'favoriteWidget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     final BottomNavigationBar navBar =
            //         navBarGlobalKey.currentWidget;
            //     navBar.onTap(2);
            //   },
            //   //child: ContainerGraph(null),
            //   child: HorizontalBarLabelChart(_sliderPopup),
            //),
            HorizontalBarLabelChart(_sliderPopup),
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
    return Consumer(
      builder: (context, watch, child) {
        final response = watch(favoritesNotifierProvider.state);
        return response.when(
          data: (response) {
            // return Column(
            //     children: response.map((recipe) => Text(recipe.id)).toList());
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
                  items: response
                      .map((recipe) => FavoriteWidget(recipe: recipe))
                      .toList(),
                ),
                Center(
                  child: DotsIndicator(
                    dotsCount: response.length,
                    position: _current.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
          error: (err, st) => Text(err.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
      // child: Column(
      //   children: [
      //     CarouselSlider(
      //       options: CarouselOptions(
      //         viewportFraction: 0.8,
      //         initialPage: 0,
      //         pageViewKey: PageStorageKey<String>('carousel_slider'),
      //         enableInfiniteScroll: false,
      //         onPageChanged: (index, reason) {
      //           setState(() {
      //             _current = index;
      //           });
      //         },
      //       ),
      //       items: getFavorites(),
      //     ),
      //     Center(
      //       child: DotsIndicator(
      //         dotsCount: 5,
      //         position: _current.toDouble(),
      //         decorator: DotsDecorator(
      //           activeColor: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

List<Widget> getFavorites() {
  // get a list of recipes
  // filter by favorites
  // map each recipe to a FavoriteWidget

  List<Widget> list = [];
  for (int i = 0; i < 5; i++) {
    Recipe recipe = new Recipe(title: "my recipe title");
    list.add(FavoriteWidget(recipe: recipe));
  }
  return list;
}

// // make this dynamic by getting recipe objects from API, list of Recipe view widgets?
// List<Widget> getFavorites(context) {
//   List<Widget> list = [];

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

//   for (int i = 0; i < 5; i++) {
//     list.add(
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 5.0),
//         width: MediaQuery.of(context).size.width,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//           color: Color(0xFF2F3D46),
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             children: [
//               Text(
//                 'Favorite #' + (i + 1).toString(),
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               Text(
//                 'Secondary Text',
//                 style: Theme.of(context).textTheme.subtitle1,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Blah Blah Blah Blah Blah Blah Blah',
//                   style: Theme.of(context).textTheme.bodyText2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   return list;
// }

Future<ContainerData> _sliderPopup(context, ContainerData container) async {
  int currentAmount = container.percentFull;

  ContainerData res = await showModalBottomSheet<ContainerData>(
    //barrierColor: Colors.transparent,
    backgroundColor: Color(0xFF2F3D46), //Colors.blueGrey[500],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownSearch<Ingredient>(
                  // dropDownButton: SizedBox(),
                  mode: Mode.DIALOG,
                  showSelectedItem: true,
                  autoFocusSearchBox: true,
                  onFind: (filter) =>
                      getIngredientList(container.containerType),
                  onChanged: (newIngredient) {
                    setState(() {
                      container.ingredient = newIngredient;
                    });
                  },
                  compareFn: (Ingredient i, Ingredient s) => i.isEqual(s),
                  //itemAsString: (Ingredient i) => i.ingredientAsString(),
                  showSearchBox: true,
                  //autoFocusSearchBox: true,
                  popupBackgroundColor: Color(0xFF2F3D46),
                  popupTitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text("Ingredients",
                            style: TextStyle(fontSize: 28))),
                  ),
                  popupShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  popupItemBuilder: (context, item, isSelected) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(item.name),
                        leading: Icon(
                            IconData(item.iconCode, fontFamily: 'CustomIcons'),
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            size: 32),
                      ),
                    );
                  },
                  dropdownBuilder: (context, selectedItem, itemAsString) {
                    // if (container.ingredient == null) {
                    //   return Text("Empty",
                    //       style: TextStyle(color: Colors.black, fontSize: 20));
                    // }
                    // return Text(container.ingredient.name,
                    //     style: TextStyle(color: Colors.black, fontSize: 24));
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black, width: 5),
                        borderRadius: BorderRadius.circular(10),
                        color: container.ingredient != null
                            ? Color(container.ingredient.colorValue)
                            : Colors.lightBlue[100], //Color(0xFF788388),
                      ),
                      child: container.ingredient != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  IconData(container.ingredient.iconCode,
                                      fontFamily: 'CustomIcons'),
                                  color: Colors.black,
                                  size: 50,
                                ),
                                Text(container.ingredient.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            )
                          : Center(
                              child: Text("Empty",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20))),
                    );
                  },
                  dropdownSearchDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // prefixIcon: container.ingredient != null
                    //     ? Icon(IconData(container.ingredient.iconCode,
                    //         fontFamily: 'CustomIcons'))
                    //     : null,
                    //prefixIcon: null,
                    //suffixIcon: null,
                    //prefix: SizedBox(),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    //prefixIconConstraints:
                    //    BoxConstraints(maxWidth: 0, maxHeight: 0),
                    // suffixIconConstraints:
                    //     BoxConstraints(maxWidth: 0, maxHeight: 0),
                    filled: true,
                    fillColor: container.ingredient == null
                        ? Colors.lightBlue[100]
                        : Color(container.ingredient.colorValue),
                  ),
                  emptyBuilder: (context, string) {
                    return Container(
                      //color: Colors.blue,
                      child: Center(
                        child: Text(
                          "No Results",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              container.ingredient != null
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          container.ingredient = null;
                          currentAmount = 0;
                        });
                      },
                      child: Text(
                        "Remove ingredient?",
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Container(),
              SfSliderTheme(
                data: SfSliderThemeData(
                  activeTrackHeight: MediaQuery.of(context).size.height / 15,
                  inactiveTrackHeight: MediaQuery.of(context).size.height / 15,
                  thumbRadius: 0.0,
                  trackCornerRadius: 7.0,
                  activeTickColor: Colors.white,
                  activeMinorTickColor: Colors.white,
                  activeLabelStyle:
                      TextStyle(color: Colors.white, fontSize: 14),
                  inactiveLabelStyle:
                      TextStyle(color: Colors.grey, fontSize: 14),
                  tickSize: Size(1.0, 12.0),
                  minorTickSize: Size(1.0, 8.0),
                ),
                child: SfSlider(
                  min: 0.0,
                  max: 100.0,
                  interval: 25,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 4,
                  // showDivisors: true,
                  showTicks: true,
                  labelFormatterCallback: (actualValue, formattedText) =>
                      actualValue.toInt().toString() + "%",
                  tooltipTextFormatterCallback: (actualValue, formattedText) =>
                      actualValue.toInt().toString() + "%",
                  stepSize: 5.0,
                  activeColor: container.ingredient != null
                      ? Color(container.ingredient.colorValue)
                      : Colors.transparent,
                  inactiveColor: container.ingredient != null
                      ? Color(container.ingredient.colorValue).withOpacity(0.2)
                      : Colors.transparent.withOpacity(0.2),
                  value: currentAmount.toDouble(),
                  // numberFormat: NumberFormat.percentPattern(),
                  onChanged: (newAmount) {
                    if (container.ingredient != null) {
                      setState(() => {currentAmount = newAmount.toInt()});
                    } else {
                      setState(() => {currentAmount = 0});
                    }
                  },
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  // save to database,
                  container.percentFull = currentAmount;

                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  String user = sharedPreferences.getString('user');
                  await editContainer(user, container)
                      .then((val) => Navigator.pop(context, container));
                },
                disabledColor: Colors.grey,
                minWidth: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 17,
                color: Color(0xFF48C28C), //Colors.green,
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },
  );
  return res;
}

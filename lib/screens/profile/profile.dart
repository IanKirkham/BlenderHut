import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is our profile page', style: TextStyle(fontSize: 20)),
    );
    // return Center(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Icon(Icons.favorite_border, size: 40, color: Colors.grey),
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             height: MediaQuery.of(context).size.height / 28,
    //             width: MediaQuery.of(context).size.width * 0.80,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(5),
    //                 topRight: Radius.circular(5),
    //               ),
    //               color: Color(0xFF2F3D46), //Colors.blueGrey[400],
    //             ),
    //             child: Stack(
    //               children: [
    //                 Align(
    //                   child: Text("Title Here",
    //                       style: GoogleFonts.montserrat(
    //                         fontSize: 18,
    //                       )),
    //                 ),
    //                 Positioned(
    //                   right: 7,
    //                   top: 3,
    //                   child: Text(
    //                     "Edit",
    //                     style: GoogleFonts.montserrat(
    //                       fontSize: 18,
    //                       fontStyle: FontStyle.italic,
    //                       color: Colors.grey[400],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             height: MediaQuery.of(context).size.height / 8,
    //             width: MediaQuery.of(context).size.width *
    //                 0.80, // Change 0.80 to a constant, used to calculate inside container widths
    //             // also change 5 to a constant, just use the number of ingredients in a recipe
    //             clipBehavior: Clip.antiAlias,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(5),
    //                 bottomRight: Radius.circular(5),
    //               ),
    //             ),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width * 0.8 / 5,
    //                   color: Colors.red[200],
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       Icon(CustomIcons.peach, size: 40),
    //                       Text(
    //                         "1 cup",
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width * 0.8 / 5,
    //                   color: Colors.orange[100],
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       Icon(CustomIcons.ice_cream, size: 40),
    //                       Text(
    //                         "3/4 cup",
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width * 0.8 / 5,
    //                   color: Colors.white,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       Icon(CustomIcons.milk, size: 40),
    //                       Text(
    //                         "2 cups",
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width * 0.8 / 5,
    //                   color: Colors.yellow,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       Icon(CustomIcons.bananas, size: 40),
    //                       Text(
    //                         "1/2 cup",
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   height: MediaQuery.of(context).size.height,
    //                   width: MediaQuery.of(context).size.width * 0.8 / 5,
    //                   color: Colors.red,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       Icon(CustomIcons.strawberry, size: 40),
    //                       Text(
    //                         "1 cup",
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 14,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

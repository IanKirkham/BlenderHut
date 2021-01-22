import 'package:blenderapp/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This is our profile page', style: TextStyle(fontSize: 20)),
        MaterialButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('user');
            Navigator.of(context, rootNavigator: true).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          color: Colors.red,
          height: 30,
          child: Text("Logout"),
        ),
        MaterialButton(
          onPressed: () => setState(() {}),
          color: Colors.purple,
        ),
        //StackWithOverflowClipped(),
        //CustomBlenderWidget(),
        Stack(
          children: [
            Container(
              height: 400,
              width: 400,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/images/blender_graphic.png'),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Container(
              // width: 400,
              // height: 400,
              child: CustomBlenderWidget(),
              // child: LiquidCustomProgressIndicator(
              //   direction: Axis.vertical,
              //   value: 0.4,
              //   valueColor: AlwaysStoppedAnimation(
              //     Colors.pink,
              //   ),
              //   backgroundColor: Colors.white,
              //   center: Text("80%", style: TextStyle(color: Colors.black)),
              //   shapePath: getPath(
              //     Size(400, 400),
              //   ),
              // ),
            ),
            Container(
              width: 385,
              height: 400,
              child: Center(child: Text("~50%")),
            )
          ],
        ),
      ],
    );
  }

  // Path getPath(Size size) {
  //   final path = new Path();
  //   path.moveTo(size.width * 0.38, size.height * 0.65);
  //   path.lineTo(size.width * 0.30, size.height * 0.50);
  //   path.lineTo(size.width * 0.30, size.height * 0.12);
  //   path.lineTo(size.width * 0.64, size.height * 0.12);
  //   path.lineTo(size.width * 0.64, size.height * 0.50);
  //   path.lineTo(size.width * 0.56, size.height * 0.65);
  //   path.lineTo(size.width * 0.38, size.height * 0.65);
  //   path.close();
  //   return path;
  // }
}

class CustomBlenderWidget extends StatelessWidget {
  final shapePath = getPath(Size(400, 400));

  @override
  Widget build(BuildContext context) {
    final pathBounds = shapePath.getBounds();
    return SizedBox(
      width: pathBounds.width + pathBounds.left,
      height: pathBounds.height + pathBounds.top,
      child: ClipPath(
        clipper: _CustomPathClipper(
          path: shapePath,
        ),
        child: CustomPaint(
          painter: _CustomPathPainter(
            color: Colors.white.withOpacity(0.5),
            path: shapePath,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                left: pathBounds.left,
                top: pathBounds.top,
                child: Wave(
                  value: 0.5,
                  color: Colors.purple, //Colors.transparent, //Colors.purple,
                  direction: Axis.vertical,
                ),
              ),
              //Center(child: Text("50%", style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }

  static Path getPath(Size size) {
    final path = new Path();
    path.moveTo(size.width * 0.38, size.height * 0.65);
    // path.quadraticBezierTo(size.width * 0.38, size.height * 0.50,
    //     size.width * 0.30, size.height * 0.50);
    // path.quadraticBezierTo(size.height * 0.50, size.width * 0.30,
    //     size.height * 0.65, size.width * 0.38);

    // path.quadraticBezierTo(size.width * 0.27, size.height * 0.55,
    //     size.width * 0.3, size.height * 0.12);
    // path.lineTo(size.width * 0.3, size.height * 0.58);
    // // path.lineTo(size.width * 0.30, size.height * 0.12);

    path.cubicTo(
      size.width * 0.26,
      size.height * 0.50,
      size.width * 0.29,
      size.height * 0.35,
      size.width * 0.29,
      size.height * 0.12,
    );

    //path.lineTo(size.width * 0.30, size.height * 0.50);
    //path.lineTo(size.width * 0.30, size.height * 0.12);
    path.lineTo(size.width * 0.64, size.height * 0.12);

    //path.moveTo(size.width * 0.56, size.height * 0.65);
    // path.cubicTo(size.width * 0.73, size.height * 0.35, size.width * 0.55,
    //     size.height * 0.50, size.width * 0.56, size.height * 0.65);
    // path.cubicTo(
    //   size.width * 0.68,
    //   size.height * 0.50,
    //   size.width * 0.64,
    //   size.height * 0.35,
    //   size.width * 0.64,
    //   size.height * 0.12,
    // );

    path.cubicTo(
      size.width * 0.64,
      size.height * 0.35,
      size.width * 0.67,
      size.height * 0.50,
      size.width * 0.56,
      size.height * 0.65,
    );
    //path.moveTo(size.width * 0.56, size.height * 0.65);

    //path.lineTo(size.width * 0.64, size.height * 0.50);
    //path.lineTo(size.width * 0.56, size.height * 0.65);
    path.lineTo(size.width * 0.38, size.height * 0.65);
    path.close();
    return path;
  }
}

class _CustomPathPainter extends CustomPainter {
  final Color color;
  final Path path;

  _CustomPathPainter({@required this.color, @required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomPathPainter oldDelegate) =>
      color != oldDelegate.color || path != oldDelegate.path;
}

class _CustomPathClipper extends CustomClipper<Path> {
  final Path path;

  _CustomPathClipper({@required this.path});

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// class StackWithOverflowClipped extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   height: 200,
//     //   width: 200,
//     //   color: Colors.grey[200],
//     //   child: Stack(
//     //     overflow: Overflow.clip,
//     //     children: [
//     //       Container(
//     //         height: 50,
//     //         width: 300,
//     //         color: Colors.blue,
//     //       )
//     //     ],
//     //   ),
//     // );
//     return Stack(
//       children: [
//         Container(
//           height: 400,
//           width: 400,
//           padding: EdgeInsets.all(10),
//           child: Image.asset('assets/images/blender_graphic.png'),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         ClipPath(
//           child: CustomPaint(
//             painter: _CustomPathPainter(
//               color: Colors.pink,
//               path: getPath(Size(400, 400)),
//             ),
//             child: Stack(
//               children: <Widget>[
//                 Positioned.fill(
//                   // left: pathBounds.left,
//                   // top: pathBounds.top,
//                   child: Container(
//                     height: 300,
//                     color: Colors.yellow,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           clipper: MyCustomClipper(path: getPath(Size(400, 400))),
//         ),
//       ],
//     );
//   }

//   Path getPath(Size size) {
//     final path = new Path();
//     path.moveTo(size.width * 0.38, size.height * 0.65);
//     path.lineTo(size.width * 0.30, size.height * 0.50);
//     path.lineTo(size.width * 0.30, size.height * 0.12);
//     path.lineTo(size.width * 0.64, size.height * 0.12);
//     path.lineTo(size.width * 0.64, size.height * 0.50);
//     path.lineTo(size.width * 0.56, size.height * 0.65);
//     path.lineTo(size.width * 0.38, size.height * 0.65);
//     path.close();
//     return path;
//   }
// }

// class _CustomPathPainter extends CustomPainter {
//   final Color color;
//   final Path path;

//   _CustomPathPainter({@required this.color, @required this.path});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = color;
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(_CustomPathPainter oldDelegate) => false;
// }

// // class _CustomPathClipper extends CustomClipper<Path> {
// //   final Path path;

// //   _CustomPathClipper({@required this.path});

// //   @override
// //   Path getClip(Size size) {
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // }

// class MyCustomClipper extends CustomClipper<Path> {
//   final Path path;
//   MyCustomClipper({@required this.path});

//   @override
//   getClip(Size size) {
//     // final path = new Path();
//     // path.moveTo(size.width * 0.38, size.height * 0.65);
//     // path.lineTo(size.width * 0.30, size.height * 0.50);
//     // path.lineTo(size.width * 0.30, size.height * 0.12); //calculatedHeight
//     // path.lineTo(size.width * 0.64, size.height * 0.12); //calculatedHeight
//     // path.lineTo(size.width * 0.64, size.height * 0.50);
//     // path.lineTo(size.width * 0.56, size.height * 0.65);
//     // path.lineTo(size.width * 0.38, size.height * 0.65);
//     // path.close();
//     // return path;
//     return path;
//   }

//   @override
//   bool shouldReclip(oldClipper) => false;
// }

// // return SizedBox(
// //   width: pathBounds.width + pathBounds.left,
// //   height: pathBounds.height + pathBounds.top,
// //   child: ClipPath(
// //     clipper: _CustomPathClipper(
// //       path: widget.shapePath,
// //     ),
// //     child: CustomPaint(
// //       painter: _CustomPathPainter(
// //         color: widget._getBackgroundColor(context),
// //         path: widget.shapePath,
// //       ),
// //       child: Stack(
// //         children: <Widget>[
// //           Positioned.fill(
// //             left: pathBounds.left,
// //             top: pathBounds.top,
// //             child: Wave(
// //               value: widget.value,
// //               color: widget._getValueColor(context),
// //               direction: widget.direction,
// //             ),
// //           ),
// //           if (widget.center != null) Center(child: widget.center),
// //         ],
// //       ),
// //     ),
// //   ),
// // );
class Wave extends StatefulWidget {
  final double value;
  final Color color;
  final Axis direction;

  const Wave({
    Key key,
    @required this.value,
    @required this.color,
    @required this.direction,
  }) : super(key: key);

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        child: Container(
          color: widget.color,
        ),
        clipper: _WaveClipper(
          animationValue: _animationController.value,
          value: widget.value,
          direction: widget.direction,
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double value;
  final Axis direction;

  _WaveClipper({
    @required this.animationValue,
    @required this.value,
    @required this.direction,
  });

  @override
  Path getClip(Size size) {
    if (direction == Axis.horizontal) {
      Path path = Path()
        ..addPolygon(_generateHorizontalWavePath(size), false)
        ..lineTo(0.0, size.height)
        ..lineTo(0.0, 0.0)
        ..close();
      return path;
    }

    Path path = Path()
      ..addPolygon(_generateVerticalWavePath(size), false)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    return path;
  }

  List<Offset> _generateHorizontalWavePath(Size size) {
    final waveList = <Offset>[];
    for (int i = -2; i <= size.height.toInt() + 2; i++) {
      final waveHeight = (size.width / 20);
      final dx = math.sin((animationValue * 360 - i) % 360 * (math.pi / 180)) *
              waveHeight +
          (size.width * value);
      waveList.add(Offset(dx, i.toDouble()));
    }
    return waveList;
  }

  List<Offset> _generateVerticalWavePath(Size size) {
    final waveList = <Offset>[];
    for (int i = -2; i <= size.width.toInt() + 2; i++) {
      final waveHeight = (size.height / 150);
      final dy = math.sin((animationValue * 360 - i) % 360 * (math.pi / 180)) *
              waveHeight +
          (size.height - (size.height * value));
      waveList.add(Offset(i.toDouble(), dy));
    }
    return waveList;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) =>
      animationValue != oldClipper.animationValue;
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomBlenderWidget extends StatelessWidget {
  final double value;
  CustomBlenderWidget({@required this.value});

  @override
  Widget build(BuildContext context) {
    final shapePath = getPath(
      Size(
        MediaQuery.of(context).size.width * 0.45,
        MediaQuery.of(context).size.width * 0.45,
      ),
    );
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
                  value: value,
                  color: Colors.purpleAccent[100],
                  direction: Axis.vertical,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Path getPath(Size size) {
    final path = new Path();
    path.moveTo(size.width * 0.38, size.height * 0.65);
    path.cubicTo(
      size.width * 0.26,
      size.height * 0.50,
      size.width * 0.29,
      size.height * 0.35,
      size.width * 0.29,
      size.height * 0.14,
    );
    path.lineTo(size.width * 0.64, size.height * 0.14);
    path.cubicTo(
      size.width * 0.64,
      size.height * 0.35,
      size.width * 0.67,
      size.height * 0.50,
      size.width * 0.56,
      size.height * 0.65,
    );
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
      final waveHeight = (size.height / 50);
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

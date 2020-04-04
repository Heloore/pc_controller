import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class _SegmentButtonPainter extends CustomPainter {
  final double offset;
  final double width;

  double start;
  double end;
  double innerRadius;
  double outerRadius;
  Color color;

  Path path;

  _SegmentButtonPainter(this.start, this.end, this.color, this.width, this.offset);

  @override
  bool shouldRepaint(_SegmentButtonPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end || oldDelegate.innerRadius != innerRadius || oldDelegate.outerRadius != outerRadius || oldDelegate.color != color;
  }

  @override
  bool shouldRebuildSemantics(_SegmentButtonPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    outerRadius = size.width / 2;
    innerRadius = outerRadius - width;
    path = Path()
      ..arcTo(Rect.fromLTWH(0, 0, outerRadius * 2, outerRadius * 2), offset + start, end - start, true)
      ..relativeLineTo(-cos(offset + end) * (outerRadius - innerRadius), -sin(offset + end) * (outerRadius - innerRadius))
      ..arcTo(Rect.fromLTWH(outerRadius - innerRadius, outerRadius - innerRadius, innerRadius * 2, innerRadius * 2), offset + end, start - end, false)
      ..close();

    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool hitTest(Offset position) {
    return path.contains(position);
  }
}

class _CircularButtonPainter extends CustomPainter {
  final double radius;
  Path path;
  _CircularButtonPainter(this.radius) {
    path = Path()..addOval(Rect.fromLTWH(0, 0, radius * 2, radius * 2));
  }
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      path,
      Paint()..color = Colors.lime,
    );
  }

  @override
  bool hitTest(Offset position) {
    return path.contains(position);
  }

  @override
  bool shouldRepaint(_CircularButtonPainter oldDelegate) => oldDelegate.radius != radius;
}

class ControlsButtons extends StatelessWidget {
  final Function() onLeftTap;
  final Function() onRightTap;
  final Function() onTopTap;
  final Function() onBottomTap;
  final Function() onCenterTap;

  final double buttonWidth;

  ControlsButtons({
    @required this.onLeftTap,
    @required this.onRightTap,
    @required this.onTopTap,
    @required this.onBottomTap,
    @required this.onCenterTap,
    @required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxWidth,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: _CircularButtton(
                radius: constraints.maxWidth / 2 - buttonWidth,
                gap: 6,
                onTap: onCenterTap,
              ),
            ),
            _SegmentButton(
              radius: constraints.maxWidth / 2,
              direction: SegmentButtonDirection.top,
              color: Colors.orange,
              onTap: onTopTap,
              buttonWidgth: buttonWidth,
            ),
            _SegmentButton(
              radius: constraints.maxWidth / 2,
              direction: SegmentButtonDirection.bottom,
              color: Colors.orange,
              onTap: onBottomTap,
              buttonWidgth: buttonWidth,
            ),
            _SegmentButton(
              radius: constraints.maxWidth / 2,
              direction: SegmentButtonDirection.left,
              onTap: onLeftTap,
              buttonWidgth: buttonWidth,
            ),
            _SegmentButton(
              radius: constraints.maxWidth / 2,
              direction: SegmentButtonDirection.right,
              color: Colors.deepPurple,
              onTap: onRightTap,
              buttonWidgth: buttonWidth,
            ),
          ],
        ),
      );
    });
  }
}

class _CircularButtton extends StatelessWidget {
  final double radius;
  final double gap;
  final Function onTap;

  const _CircularButtton({
    Key key,
    this.radius,
    this.onTap,
    this.gap = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2 - gap * 2,
      width: radius * 2 - gap * 2,
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: _CircularButtonPainter(radius - gap),
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final double radius;
  final double buttonWidgth;
  final Color color;
  final Function onTap;
  final SegmentButtonDirection direction;

  _SegmentButton({
    Key key,
    @required this.radius,
    @required this.direction,
    this.color = Colors.deepOrange,
    @required this.onTap,
    @required this.buttonWidgth,
  })  : assert(
          radius != null && direction != null && onTap != null,
        ),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: _SegmentButtonPainter(
            (-pi / 4) + (1 * (pi / 180)),
            (pi / 4) - (1 * (pi / 180)),
            color,
            buttonWidgth,
            _getSegmentOffset(direction),
          ),
        ),
      ),
    );
  }

  double _getSegmentOffset(SegmentButtonDirection direction) {
    switch (direction) {
      case SegmentButtonDirection.top:
        return -pi / 2;
      case SegmentButtonDirection.bottom:
        return pi / 2;
      case SegmentButtonDirection.left:
        return 0;
      case SegmentButtonDirection.right:
        return pi;
    }
    throw ArgumentError("Unknown direction: $direction");
  }
}

enum SegmentButtonDirection {
  top,
  bottom,
  left,
  right,
}
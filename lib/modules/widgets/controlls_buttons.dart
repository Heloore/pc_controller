import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _SegmentButtonPainter extends CustomPainter {
  final double offset;
  final double lineWidth;
  final double start;
  final double end;
  final Color color;

  final List<Offset> points;
  final Color pointsColor;

  Path path;

  _SegmentButtonPainter(
    this.start,
    this.end,
    this.color,
    this.lineWidth,
    this.offset, {
    this.points,
    this.pointsColor = Colors.white,
  });

  @override
  bool shouldRepaint(_SegmentButtonPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end || oldDelegate.color != color || oldDelegate.offset != offset || oldDelegate.lineWidth != lineWidth;
  }

  @override
  bool shouldRebuildSemantics(_SegmentButtonPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    double outerRadius = size.width / 2;
    double innerRadius = outerRadius - lineWidth;
    path = Path()
      ..arcTo(Rect.fromLTWH(0, 0, outerRadius * 2, outerRadius * 2), offset + start, end - start, true)
      ..relativeLineTo(-cos(offset + end) * (outerRadius - innerRadius), -sin(offset + end) * (outerRadius - innerRadius))
      ..arcTo(Rect.fromLTWH(outerRadius - innerRadius, outerRadius - innerRadius, innerRadius * 2, innerRadius * 2), offset + end, start - end, false)
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    if (points != null) {
      canvas.drawPoints(
        PointMode.polygon,
        points,
        Paint()
          ..color = pointsColor
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      );
    }
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

  final Widget centralWidget;
  final double buttonWidth;
  final bool vibroFeedback;

  ControlsButtons({
    @required this.onLeftTap,
    @required this.onRightTap,
    @required this.onTopTap,
    @required this.onBottomTap,
    @required this.onCenterTap,
    @required this.buttonWidth,
    this.centralWidget,
    this.vibroFeedback = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(constraints.maxHeight != double.infinity && constraints.maxHeight != null);
      double squareSide = constraints.maxHeight;
      return Container(
        width: squareSide,
        height: squareSide,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: _CircularButtton(
                radius: squareSide / 2 - buttonWidth,
                gap: 0.0166 * squareSide,
                onTap: onCenterTap,
                centralWidget: centralWidget ?? Container(),
              ),
            ),
            _SegmentButton(
              radius: squareSide / 2,
              direction: SegmentButtonDirection.top,
              color: Colors.orange,
              onTap: onTopTap,
              buttonWidgth: buttonWidth,
              withIcon: true,
            ),
            _SegmentButton(
              radius: squareSide / 2,
              direction: SegmentButtonDirection.bottom,
              color: Colors.orange,
              onTap: onBottomTap,
              buttonWidgth: buttonWidth,
              withIcon: true,
            ),
            _SegmentButton(
              radius: squareSide / 2,
              direction: SegmentButtonDirection.left,
              color: Colors.deepPurple,
              onTap: onLeftTap,
              buttonWidgth: buttonWidth,
              withIcon: true,
            ),
            _SegmentButton(
              radius: squareSide / 2,
              direction: SegmentButtonDirection.right,
              color: Colors.deepPurple,
              onTap: onRightTap,
              buttonWidgth: buttonWidth,
              withIcon: true,
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
  final Widget centralWidget;

  const _CircularButtton({
    Key key,
    this.radius,
    this.onTap,
    this.gap = 0,
    this.centralWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2 - gap * 2,
      width: radius * 2 - gap * 2,
      child: GestureDetector(
        onTapDown: (_) {
          HapticFeedback.lightImpact();
        },
        onTapUp: (_) {
          HapticFeedback.heavyImpact();
        },
        onTap: onTap,
        child: CustomPaint(
          painter: _CircularButtonPainter(radius - gap),
          child: centralWidget,
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
  final bool withIcon;
  final bool vibroFeedback;

  final double containerHeight;
  final double containerWidth;

  _SegmentButton({
    Key key,
    @required this.radius,
    @required this.direction,
    this.color = Colors.black,
    @required this.onTap,
    @required this.buttonWidgth,
    this.withIcon = false,
    this.vibroFeedback = false,
  })  : assert(
          radius != null && direction != null && onTap != null,
        ),
        containerHeight = radius * 2,
        containerWidth = radius * 2,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      child: GestureDetector(
        onTapDown: (_) {
          HapticFeedback.lightImpact();
        },
        onTapUp: (_) {
          HapticFeedback.heavyImpact();
        },
        onTap: onTap,
        child: CustomPaint(
          painter: _SegmentButtonPainter(
            (-pi / 4) + (1 * (pi / 180)),
            (pi / 4) - (1 * (pi / 180)),
            color,
            buttonWidgth,
            _getSegmentOffset(direction),
            points: withIcon ? _getArrowIconPointsForButton(direction) : null,
          ),
        ),
      ),
    );
  }

  List<Offset> _getArrowIconPointsForButton(SegmentButtonDirection direction) {
    double iconSize = buttonWidgth / 5;
    switch (direction) {
      case SegmentButtonDirection.top:
        return [
          Offset(containerWidth / 2 - iconSize * 1.5, buttonWidgth / 2 + iconSize / 1.5),
          Offset(containerWidth / 2, buttonWidgth / 2 - iconSize / 1.5),
          Offset(containerWidth / 2 + iconSize * 1.5, buttonWidgth / 2 + iconSize / 1.5),
        ];
      case SegmentButtonDirection.bottom:
        return [
          Offset(containerWidth / 2 - iconSize * 1.5, containerHeight - buttonWidgth / 2 - iconSize / 1.5),
          Offset(containerWidth / 2, containerHeight - buttonWidgth / 2 + iconSize / 1.5),
          Offset(containerWidth / 2 + iconSize * 1.5, containerHeight - buttonWidgth / 2 - iconSize / 1.5),
        ];
      case SegmentButtonDirection.left:
        return [
          Offset(buttonWidgth / 2 + iconSize / 1.5, containerHeight / 2 - iconSize * 1.5),
          Offset(buttonWidgth / 2 - iconSize / 1.5, containerHeight / 2),
          Offset(buttonWidgth / 2 + iconSize / 1.5, containerHeight / 2 + iconSize * 1.5),
        ];
      case SegmentButtonDirection.right:
        return [
          Offset(containerWidth - buttonWidgth / 2 - iconSize / 1.5, containerHeight / 2 - iconSize * 1.5),
          Offset(containerWidth - buttonWidgth / 2 + iconSize / 1.5, containerHeight / 2),
          Offset(containerWidth - buttonWidgth / 2 - iconSize / 1.5, containerHeight / 2 + iconSize * 1.5),
        ];
    }
    throw ArgumentError("Unknown direction: $direction");
  }

  double _getSegmentOffset(SegmentButtonDirection direction) {
    switch (direction) {
      case SegmentButtonDirection.top:
        return -pi / 2;
      case SegmentButtonDirection.bottom:
        return pi / 2;
      case SegmentButtonDirection.left:
        return pi;
      case SegmentButtonDirection.right:
        return 0;
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

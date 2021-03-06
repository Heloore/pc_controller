import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class TouchPad extends StatefulWidget {
  final ValueChanged<Offset> onChanged;

  const TouchPad({Key key, this.onChanged}) : super(key: key);

  @override
  TouchPadState createState() => TouchPadState();
}

class TouchPadState extends State<TouchPad> {
  double xPos = 0.0;
  double yPos = 0.0;

  void onChanged(Offset offset) {
    final RenderBox referenceBox = context.findRenderObject();
    Offset position = referenceBox.globalToLocal(offset);
    if (widget.onChanged != null) widget.onChanged(position);

    double width = referenceBox.size.width;
    double height = referenceBox.size.height;

    double x = position.dx;
    double y = position.dy;

    if (x > width) {
      x = width;
    } else if (x < 0) {
      x = 0.0;
    }

    if (y > height) {
      y = height;
    } else if (y < 0) {
      y = 0.0;
    }

    print('x:$x:$width, y:$y:$height');

    setState(() {
      xPos = x - (width / 2);
      yPos = y - (height / 2);
    });
  }

  void _handlePanStart(DragStartDetails details) {
    onChanged(details.globalPosition);
  }

  void _handlePanEnd(DragEndDetails details) {
    print('end');
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    onChanged(details.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: _handlePanStart,
        onHorizontalDragUpdate: _handlePanUpdate,
        onHorizontalDragEnd: _handlePanEnd,
        onPanStart: _handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: CustomPaint(
          painter: TouchPadGridPainter(),
          child: Center(
            child: CustomPaint(
              painter: TouchPadPainter(xPos, yPos),
            ),
          ),
        ),
      ),
    );
  }
}

class TouchPadPainter extends CustomPainter {
  static const markerRadius = 10.0;

  Offset position;

  TouchPadPainter(final double x, final double y) {
    this.position = Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(position.dx, position.dy), markerRadius, paint);
  }

  @override
  bool shouldRepaint(TouchPadPainter old) => position.dx != old.position.dx && position.dy != old.position.dy;
}

class TouchPadGridPainter extends CustomPainter {
  Offset position;

  TouchPadGridPainter() {
    this.position = Offset(0.0, 0.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;

    Offset centreLeft = size.centerLeft(position);
    Offset centreRight = size.centerRight(position);

    canvas.drawLine(centreLeft, centreRight, paint);

    Offset topCentre = size.topCenter(position);
    Offset bottomCentre = size.bottomCenter(position);

    canvas.drawLine(topCentre, bottomCentre, paint);
  }

  @override
  bool shouldRepaint(TouchPadGridPainter old) => position.dx != old.position.dx && position.dy != old.position.dy;
}

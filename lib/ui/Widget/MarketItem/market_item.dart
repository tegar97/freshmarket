import 'package:flutter/material.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';

class MarkerItem {
  /// Initialize instance
  static MarkerItem instance = MarkerItem();



  Widget myLocationMarker() {
    return Consumer<MapProvider>(
      builder: (context, mapProv, _) {
        return RepaintBoundary(
          key: mapProv.myLocationKey,
          child: Container(
            width: 200,
            height: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            spreadRadius: 1,
                            color: Colors.grey.withOpacity(0.3))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.white,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: Container(
                      width: 16,
                      height: 13,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: Colors.grey.withOpacity(0.5))
                        ]),
                    child:
                        Icon(Icons.location_on, color: Colors.white, size: 25)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
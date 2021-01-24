import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder({
    this.side = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
  }) : assert(side != null),
        assert(borderRadius != null);

  final BorderRadiusGeometry borderRadius;

  /// The style of this border.
  final BorderSide side;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    assert(t != null);
    if (a is ContinuousRectangleBorder) {
      return ContinuousRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    assert(t != null);
    if (b is ContinuousRectangleBorder) {
      return ContinuousRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    double length = 16;
    return Path()
      ..lineTo(0, rect.height - length)
      ..lineTo(rect.width, rect.height - length)
      ..lineTo(rect.width, 0)
      ..close();
  }

  @override
  Path getOuterPath(rect, {TextDirection textDirection}) {
    double length = 16; //its just a random number I came up with to test the border
    return Path()
      ..lineTo(0, rect.height)
      ..quadraticBezierTo(length / 4, rect.height - length, length, rect.height - length)
      ..lineTo(rect.width - length, rect.height - length)
      ..quadraticBezierTo(rect.width - (length / 4), rect.height - length, rect.width, rect.height)
      ..lineTo(rect.width, 0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {
    if (rect.isEmpty)
      return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getOuterPath(rect, textDirection: textDirection);
        final Paint paint = side.toPaint();
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    return other is ContinuousRectangleBorder
        && other.side == side
        && other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);

}
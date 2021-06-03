import 'package:flutter/material.dart';
import 'package:music_app/theme.dart';

// ignore: must_be_immutable
class CircularSoftButton extends StatelessWidget {
  double radius;
  final Widget icon;

  CircularSoftButton({this.radius = 0.0, required this.icon}) {
    (radius <= 0) ? this.radius = 32 : this.radius = radius;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(radius / 2),
      child: Stack(
        children: [
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                    color: shadowColor,
                    offset: Offset(8, 6),
                    blurRadius: 12),
                BoxShadow(
                    color: whiteColor,
                    offset: Offset(-8, -6),
                    blurRadius: 12),
              ],
            ),
          ),
          Positioned.fill(child: icon),
        ],
      ),
    );
  }
}

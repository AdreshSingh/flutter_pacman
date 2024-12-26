import 'package:flutter/material.dart';

class Pixels extends StatelessWidget {
  final Color innerColor;
  final Color outerColor;
  final Widget child;
  const Pixels({
    super.key,
    required this.child,
    required this.innerColor,
    required this.outerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      //? outside of wall
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(4),
          color: outerColor,
          //? innerside of wall
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Container(color: innerColor, child: child),
            ),
          ),
        ),
      ),
    );
    
  }
}

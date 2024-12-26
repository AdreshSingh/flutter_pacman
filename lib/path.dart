import 'package:flutter/material.dart';

class Paths extends StatelessWidget {
  final Color innerColor;
  final Color outerColor;
  final Widget child;
  const Paths({
    super.key,
    required this.child,
    required this.innerColor,
    required this.outerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: outerColor,
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

import 'package:flutter/material.dart';

class Ghost extends StatelessWidget {
  const Ghost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Image.asset("lib/images/pinkghost.png"),
    );
  }
}

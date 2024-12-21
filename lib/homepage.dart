import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.red[300],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow[300],
            ),
          )
        ],
      ),
    );
  }
}

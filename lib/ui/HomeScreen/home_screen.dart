import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          ("Thanks for sign in "),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.white),
        foregroundColor: (Colors.red),
        title: Text("DedSec"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          alignment: Alignment(0.1, 0.3),
          padding: EdgeInsets.all(32),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(280, 80),
                textStyle: TextStyle(fontSize: 28),
                primary: Colors.red,
                onPrimary: Colors.black),
            child: const Text(
              'Root Checker',
            ),
            onPressed: () {},
          ),
        ),
      ]),
    ));
  }
}

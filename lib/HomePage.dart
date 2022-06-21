import 'package:project/review.dart';
import 'package:project/verify.dart';

import 'BlockList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BlockList.dart';
import 'Data.dart';
import 'nope.dart';
import 'npvpn.dart';

void main() => runApp(MyHomeApp());

/// This Widget is the main application widget.
class MyHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: (Colors.white),
          foregroundColor: (Colors.red),
          title: Text("DedSec", style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              new BoxShadow(
                color: Colors.red,
              ),
            ],
          ),
          child: Text("Welcome to DedSec App, Happy Safe Browsing!",
              style: TextStyle(fontSize: 25)),
        ),
        //Drawer Starts Here
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('DedSec Features',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: const Text('DedList', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewBuilder()),
                  );
                },
              ),
              ListTile(
                title:
                    const Text('DedSec NoVPN', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => novpn()),
                  );
                },
              ),
              ListTile(
                title: const Text('DedSec Review Checker',
                    style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => reviewc()),
                  );
                },
              ),
              ListTile(
                title:
                    const Text('DedSec Verify', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Data()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

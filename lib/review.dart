import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:project/Data.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';
import 'npvpn.dart';
import 'verify.dart';
import 'package:flutter/material.dart';
import 'BlockList.dart';

void main() {
  runApp(MaterialApp(
    home: reviewc(),
  ));
}

class reviewc extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<reviewc> {
  int pressed = 0;
  bool apiCall = false;
  TextEditingController myController = TextEditingController();
  double bval = 0.0;
  int droid = 0;

  @override
  void initState() {
    super.initState();
  }
  // apiCall IMP
  /*Widget? getProperWidget(){
    if(apiCall) {
      return const CircularProgressIndicator();
    } else {
      return null;
    }
  }*/

  Widget myWidget(BuildContext context) {
    return Column(
      children: [
        const Text(
          "The app\'s reviews and rating indicate that the app is ",
          style: TextStyle(
            fontSize: 19,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
        if (bval >= 3)
          if (pressed == 2)
            const Text(" SAFE TO USE ", style: TextStyle(fontSize: 24)),
        if (bval == 0.0) const Text("<EMPTY>", style: TextStyle(fontSize: 24)),
        if (bval < 3)
          if (pressed == 2)
            const Text("MAY NOT BE SAFE TO USE ",
                style: TextStyle(fontSize: 24)),
        const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
        Row(children: [
          const Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 0)),
          Image.asset('assets/playstore.png', width: 50, height: 50),
          if (bval >= 3)
            if (pressed == 2)
              Text("  rating is $bval.",
                  style: const TextStyle(
                    fontSize: 19,
                  )),
          if (bval < 3)
            if (pressed == 2)
              Text("  rating is $bval.",
                  style: const TextStyle(
                    fontSize: 19,
                  )),
          if (bval == 0.0)
            const Text("  rating will be visible here",
                style: TextStyle(
                  fontSize: 19,
                )),
        ]),
      ],
    );
  }

  Future<void> myfunc() async {
    String val = myController.text;
    final response =
        await http.get(Uri.parse("http://10.0.2.2:5000/api?Query=$val"));
    String jsonsDataString = response.body;
    final datab = jsonDecode(jsonsDataString);
    bval = datab["Query"];
    bval = double.parse(bval.toStringAsFixed(2));
    print(bval);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DedSec Review Checker'),
        backgroundColor: (Colors.white),
        foregroundColor: (Colors.red),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        hintText: 'Enter the Application Name',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        myfunc();
                        pressed = pressed + 1;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0), //Container
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Instructions for User"),
                                content: const Text(
                                    "User can enter the package name of an app after which we will search the play store for reviews and rating. We will then calculate whether it is safe for user to install the app.",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text("Instructions")),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0), //Container
                  ),
                  myWidget(context)
                ],
              ))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('DedSec Features',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: const Text('DedSec Home', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomeApp()),
                );
              },
            ),
            ListTile(
              title: const Text('DedSec noVPN', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => novpn()),
                );
              },
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
    );
  }
}

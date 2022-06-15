import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:project/review.dart';
import 'HomePage.dart';
import 'npvpn.dart';
import 'BlockList.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => new _DataState();
}

class _DataState extends State<Data> {
  late String x;
  late String y;
  bool pressed = false;
  TextEditingController myController = TextEditingController();
  late String value;
  late TextEditingController _controller;
  int bval = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DedSec Verify'),
        backgroundColor: (Colors.white),
        foregroundColor: (Colors.red),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    hintText:
                        'Enter the URL/IP in format of xxx.com/xxx.org/xxx.io',
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text("Hey"),

                onPressed: () async {
                  setState(() {
                    pressed = true;

                  });
                  String val = _controller.text;
                  print(val);
                  final response = await http.get(Uri.parse("http://10.0.2.2:5000/verify?Query=$val"));
                  String dbs = response.body;
                  final datab = await jsonDecode(dbs);
                  bval = datab["Query"];
                  print(bval);
                },
              ),
              if(bval > 0 ) if(pressed==true) Text("The website you have entered has shown to be malicious by VirusTotal.")
              else if(bval<=0) if(pressed==true) Text("The website you have entered has shown to be malicious by VirusTotal"),
            ],
          )),
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
              title: const Text('DedSec Review Checker',
                  style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reviewc()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  late String x;
  late String y;
  int pressed = 0;
  TextEditingController myController = TextEditingController();
  late String value;
  late TextEditingController _controller;
  int bval = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Widget myWidget(BuildContext context) {
    return Column(
      children: [
        const Text(
          "VirusTotal has searched the database and found that the website entered is ",
          style: TextStyle(
            fontSize: 19,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
        if (bval > 0) const Text(" MALICIOUS ", style: TextStyle(fontSize: 24)),
        if (bval == 0.0) const Text("<EMPTY>", style: TextStyle(fontSize: 24)),
        if (bval < 0)
          const Text("TOTALLY SAFE TO USE ", style: TextStyle(fontSize: 24)),
        const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
        Row(children: [
          const Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 0)),
          Image.asset('assets/virustotal.png', width: 50, height: 50),
          if (bval > 0)
            Text("  rating is $bval.",
                style: const TextStyle(
                  fontSize: 19,
                )),
          if (bval < 0)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DedSec Verify'),
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text("Search"),
                    onPressed: () async {
                      String val = _controller.text;
                      final response = await http.get(Uri.parse("http://10.0.2.2:5000/verify?Query=$val"));
                      setState(() {
                        String jsonsDataString = response.body;
                        final datab = jsonDecode(jsonsDataString);
                        bval = datab["Query"];
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0), //Container
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Instructions for User"),
                                content: const Text(
                                    "User can enter the domain URL of the website after which we will search the VirusTotal database by using their API for reports. VirusTotal report will let us know whether the domain is malicious or not.",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Close'),
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
                  MaterialPageRoute(builder: (context) => const MyHomeApp()),
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

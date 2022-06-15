import 'dart:async';
import 'dart:convert';

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
  bool pressed = false;
  bool apiCall = false;
  TextEditingController myController = TextEditingController();
  double bval = 0.0;

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DedSec Review Checker'),
        backgroundColor: (Colors.white),
        foregroundColor: (Colors.red),
        centerTitle: true,
      ),
      body: Padding(
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
               
                child: const Text('Search',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  setState(() {
                    pressed = true;

                  });

                  String val = myController.text;

                  final response = await http.get(Uri.parse("http://10.0.2.2:5000/api?Query=$val"));
                  String jsonsDataString = response.body;
                  print(jsonsDataString);
                  final datab = await jsonDecode(jsonsDataString);
                  print(datab);
                  bval = datab["Query"];
                  },),

        if(bval >= 3 ) if(pressed==true) Text("The app\'s reviews and rating indicate that the app is safe to use . The app rating is $bval.")
              else if(bval<3) if(pressed==true) Text("The app\'s reviews and rating indicate that the app is safe to use . The app rating is $bval"),

               const Text("\n\n\n\n Reviews taken from Google Play Store ",
                  style:  TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  )),

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

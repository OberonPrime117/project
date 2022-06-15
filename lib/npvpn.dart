import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/review.dart';
import 'package:project/verify.dart';
import 'BlockList.dart';
import 'Data.dart';
import 'HomePage.dart';
import 'dart:async';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:safetynet_attestation/models/jws_payload_model.dart';
import 'package:safetynet_attestation/safetynet_attestation.dart';

class novpn extends StatefulWidget {
  @override
  _novpnState createState() => new _novpnState();
}

/// This Widget is the main application widget.
class _novpnState extends State<novpn> {
  bool? _jailbroken;
  GooglePlayServicesAvailability? _gmsStatus;
  // AIzaSyBBa7zdGwLbr4Qk4i0_Tfwd2ihVLwPtVio NONCE
  bool _clicked = false;
  bool? _developerMode;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initPlatformState2();
  }

  Future<void> initPlatformState2() async {
    GooglePlayServicesAvailability? gmsAvailability;
    try {
      gmsAvailability =
          await SafetynetAttestation.googlePlayServicesAvailability();
    } on PlatformException {
      gmsAvailability = null;
    }

    if (!mounted) return;

    setState(() {
      _gmsStatus = gmsAvailability;

    });
  }

  void valueResult() {
    if(_gmsStatus.toString().split('.').length>1)
      {
        Text(_gmsStatus.toString().split('.')[1]);
      }
    else {
      const Text("Unknown / Google Play Connection Error");
    }

  }

  Future<void> initPlatformState() async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.white),
        foregroundColor: (Colors.red),
        title: Text("DedSec noVPN"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          alignment: Alignment(0.1, -0.3),
          padding: EdgeInsets.all(32),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(280, 80),
                textStyle: TextStyle(fontSize: 28),
                primary: Colors.red,
                onPrimary: Colors.black),
            child: Text(
              'Root Checker',
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Result'),
                  content: Text(
                      'Compromised / Rooted : ${_jailbroken == null ? "Unknown" : _jailbroken! ? "YES" : "NO"}'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Go Back'))
                  ],
                ),
              );
            },
          ),
        ),
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
              'Safety Check',
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Result'),
                  content:
                  Text("Safety Net Google API Check : ${_gmsStatus.toString().split('.').length>1 ? _gmsStatus.toString().split('.')[1] : "Failed"}"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Go Back')
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ]),
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
    ));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Root Checker'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Compromised / Rooted : ${_jailbroken == null ? "Unknown" : _jailbroken! ? "YES" : "NO"}'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }



  void requestSafetyNetAttestation() async {
    String dialogTitle, dialogMessage;
    try {
      JWSPayloadModel res =
          await SafetynetAttestation.safetyNetAttestationPayload(
              'AIzaSyCfqMjfOUSBjx6H1XFNCQdN0EypSStLIfs');

      dialogTitle = 'SafetyNet Attestation Payload';
      dialogMessage = res.toString();
    } catch (e) {
      dialogTitle = 'ERROR - SafetyNet Attestation Payload';

      if (e is PlatformException) {
        dialogMessage = e.message ?? "Error";
      } else {
        dialogMessage = e.toString();
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Text(dialogMessage),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });

    setState(() {
      isLoading = false;
    });
  }
}

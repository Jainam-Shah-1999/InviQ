import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';

class ScannerPage extends StatefulWidget {
  final FirebaseUser user;
  ScannerPage(this.user);
  @override
  _ScannerPageState createState() => _ScannerPageState(user);
}

class _ScannerPageState extends State<ScannerPage> {
  final FirebaseUser user;
  _ScannerPageState(this.user);
  String barcode = "";

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('QR Code Scanner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          new Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: scan,
                child: Text('Start QR Scan'),
              )),
          Text(
            barcode,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      authenticateGuest();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  authenticateGuest() async {
    String data = this.barcode;
    final dataToJson = jsonDecode(data);
    var a = Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(dataToJson["eventId"])
        .collection('guest')
        .document(dataToJson["guestId"])
        .snapshots()
        .isEmpty;
    if (await a) {
      print('guest not authorized');
      AlertDialog(
        title: Text('Authorization Alert'),
        content: Text('Guest is Not Authenticated!'),
        backgroundColor: Colors.red,
      );
    } else {
      print('guest authorized');
      AlertDialog(
        title: Text('Authorization Alert'),
        content: Text('Guest Authenticated!'),
        backgroundColor: Colors.green,
      );
    }
  }
}

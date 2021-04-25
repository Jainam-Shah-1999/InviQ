import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddGuest extends StatefulWidget {
  final FirebaseUser user;
  final String documentId;
  AddGuest(this.user, this.documentId);
  @override
  _AddGuestState createState() => _AddGuestState(user, documentId);
}

class _AddGuestState extends State<AddGuest> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseUser user;
  final String documentId;
  _AddGuestState(this.user, this.documentId);
  @override
  Widget build(BuildContext context) {
    final documentReference = Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(documentId)
        .collection('guest');

    //Controllers
    TextEditingController guestName = new TextEditingController();
    TextEditingController guestContactNumber = new TextEditingController();
    TextEditingController guestEmail = new TextEditingController();
    void _submitForm() {
      if (_formKey.currentState.validate()) {
        Map<String, String> data = <String, String>{
          "guestName": guestName.text,
          "guestContactNumber": guestContactNumber.text,
          "guestEmail": guestEmail.text,
          "isInvited": 'Pending',
        };
        try {
          documentReference.add(data).whenComplete(() {
            print("Guest Added!");
            Navigator.of(context).pop();
          });
        } on Exception {
          print(Exception);
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Guest'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0,
            ),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Guest Name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Guest Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      controller: guestName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Guest's contact number cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Guest's Contact Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      controller: guestContactNumber,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Guest's email cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Guest's email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      controller: guestEmail,
                    ),
                  ),
                  new ElevatedButton(
                    onPressed: _submitForm,
                    child: new Text("Add guest"),
                  ),
                ]))));
  }
}

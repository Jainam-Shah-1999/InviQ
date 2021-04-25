import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AddGuest.dart';

class AddRegistrationCodePage extends StatefulWidget {
  final FirebaseUser user;
  AddRegistrationCodePage(this.user);
  @override
  _AddRegistrationCodePageState createState() =>
      _AddRegistrationCodePageState(user);
}

class _AddRegistrationCodePageState extends State<AddRegistrationCodePage> {
  final FirebaseUser user;
  _AddRegistrationCodePageState(this.user);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Controllers
    TextEditingController eventId = new TextEditingController();
    void _submitForm() {
      if (_formkey.currentState.validate()) {
        Navigator.pop(context);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new AddGuest(user, eventId.text)));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Event Code'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Enter EventCode: (case sensitive)',
                        style: TextStyle(fontSize: 22.0))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Code cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Event Code',
                      hintText: 'Eg. A1B2C3D4E5F6G7H8I',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventId,
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitForm();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

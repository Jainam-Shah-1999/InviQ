import 'package:flutter/material.dart';

class AddRegistrationCodePage extends StatefulWidget {
  @override
  _AddRegistrationCodePageState createState() =>
      _AddRegistrationCodePageState();
}

class _AddRegistrationCodePageState extends State<AddRegistrationCodePage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Code cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Event Code',
                      hintText: 'Eg. 0000000',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formkey.currentState.validate();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEventPage extends StatefulWidget {
  final FirebaseUser user;
  final Event event;
  CreateEventPage({Key key, @required this.event, this.user});
  @override
  _CreateEventPageState createState() =>
      _CreateEventPageState(key: key, event: event, user: user);
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseUser user;
  final Event event;
  _CreateEventPageState({Key key, @required this.event, this.user});
  @override
  Widget build(BuildContext context) {
    final documentReference =
        Firestore.instance.document(user.email + '/event');
    TextEditingController eventName = new TextEditingController();
    TextEditingController eventType = new TextEditingController();
    TextEditingController eventStartDate = new TextEditingController();
    TextEditingController eventEndDate = new TextEditingController();
    TextEditingController eventLocation = new TextEditingController();
    TextEditingController numberOfGuests = new TextEditingController();
    TextEditingController invitationType = new TextEditingController();
    TextEditingController notes = new TextEditingController();

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        // eventName.text = event.eventName;
        // eventType.text = event.eventType;
        // eventStartDate.text = event.eventStartDate.toString();
        // eventEndDate.text = event.eventEndDate.toString();
        // eventLocation.text = event.eventLocation;
        // numberOfGuests.text = event.numberOfGuests;
        // invitationType.text = event.invitationType;
        // notes.text = event.notes;
        eventName.text = datasnapshot.data['eventName'];
        eventType.text = datasnapshot.data['eventType'];
        eventStartDate.text = datasnapshot.data['eventStartDate'];
        eventEndDate.text = datasnapshot.data['eventEndDate'];
        eventLocation.text = datasnapshot.data['eventLocation'];
        numberOfGuests.text = datasnapshot.data['numberOfGuests'];
        invitationType.text = datasnapshot.data['invitationType'];
        notes.text = datasnapshot.data['notes'];
      }
    });
    void _submitForm() {
      if (_formKey.currentState.validate()) {
        Map<String, String> data = <String, String>{
          "eventName": eventName.text,
          "eventType": eventType.text,
          "eventStartDate": eventStartDate.text,
          "eventEndDate": eventEndDate.text,
          "eventLocation": eventLocation.text,
          "numberOfGuests": numberOfGuests.text,
          "invitationType": invitationType.text,
          "notes": notes.text,
        };
        documentReference.setData(data).whenComplete(() {
          print("document Added!");
        }).catchError((e) => print(e));
      }
    }

    void _deleteEvent() {
      documentReference.delete().whenComplete(() {
        print("document deleted!");
      }).catchError((e) => print(e));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Name cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      hintText: 'Eg. Birthday Party of John',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event start date cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Event Start Date',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventStartDate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event end date cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Event End Date',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventEndDate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Place cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Event Place',
                      hintText: '440 Banquets',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventLocation,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Number of guests cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Number of Guests',
                      hintText: '10, 20, 30 ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: numberOfGuests,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Invitation Type Cannot be Empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Invitation Type',
                      hintText: 'Personal Invite or Registration Link',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: invitationType,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Notes (Optional)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: notes,
                  ),
                ),
                new ElevatedButton(
                  onPressed: _submitForm,
                  child: new Text("Create"),
                ),
                new ElevatedButton(
                  onPressed: _deleteEvent,
                  child: new Text("delete"),
                ),
              ],
            )),
      ),
    );
  }
}

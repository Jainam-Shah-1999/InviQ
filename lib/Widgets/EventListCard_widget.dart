import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:flutter_application_1/Views/Scanner.dart';
import 'package:flutter_application_1/Views/UpdateEvent.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void _deleteEvent(String documentId, FirebaseUser user) {
  final documentReference = Firestore.instance
      .collection('InviQ')
      .document(user.email)
      .collection('event')
      .document(documentId);
  documentReference.delete().whenComplete(() {
    print("document deleted!");
  }).catchError((e) => print(e));
}

final eventModel =
    new Event(null, null, null, null, null, null, null, null, null, null);

Widget buildTodaysEventCard(BuildContext context, DocumentSnapshot event) {
  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    event['eventName'],
                    style: new TextStyle(fontSize: 22.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Event type: " + event['eventType']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventStartDate'])).toString()} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventEndDate'])).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.watch_rounded),
                    Text(
                        "${event['eventStartTime'].toString().substring(10, 15)} - ${event['eventEndTime'].toString().substring(10, 15)}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text("Location: " + event['eventLocation']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("Invited Guests: " + event['numberOfGuests']),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new ScannerPage())),
      ),
    ),
  );
}

Widget buildUpcomingEventCard(BuildContext context, DocumentSnapshot event) {
  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    event['eventName'],
                    style: new TextStyle(fontSize: 22.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Event type: " + event['eventType']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventStartDate'])).toString()} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventEndDate'])).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.watch_rounded),
                    Text(
                        "${event['eventStartTime'].toString().substring(10, 15)} - ${event['eventEndTime'].toString().substring(10, 15)}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text("Location: " + event['eventLocation']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("Invited Guests: " + event['numberOfGuests']),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new ScannerPage())),
      ),
    ),
  );
}

Widget buildEventCardForUpdate(
    BuildContext context, DocumentSnapshot event, FirebaseUser user) {
  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    event['eventName'],
                    style: new TextStyle(fontSize: 22.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Event type: " + event['eventType']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventStartDate'])).toString()} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(event['eventEndDate'])).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.watch_rounded),
                    Text(
                        "${event['eventStartTime'].toString().substring(10, 15)} - ${event['eventEndTime'].toString().substring(10, 15)}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text("Location: " + event['eventLocation']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("Invited Guests: " + event['numberOfGuests']),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        onLongPress: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Alert!"),
                  content: Text("Do you want to delete this event?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () { _deleteEvent(event.documentID, user);
                      Navigator.of(context).pop();},
                      child: Text("Delete Event"),
                    ),
                  ],
                ),
              ),
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new UpdateEventPage(
                    event: eventModel,
                    user: user,
                    documentId: event.documentID))),
      ),
    ),
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:flutter_application_1/Views/AllGuests.dart';
import 'package:flutter_application_1/Views/InvitationCard.dart';
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
                    Text("Event Code: " + event.documentID),
                    Spacer(),
                  ],
                ),
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
                    Text("Event Code: " + event.documentID),
                    Spacer(),
                  ],
                ),
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
                    Text("Event Code: " + event.documentID),
                    Spacer(),
                  ],
                ),
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
            title: Text("Choose any Action"),
            content: Text(
                "Do yo want to Invite Guests, Update Event or Delete Event?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AllGuests(
                                  user: user,
                                  documentId: event.documentID)));
                },
                child: Text("Invite Guests"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new UpdateEventPage(
                                  event: eventModel,
                                  user: user,
                                  documentId: event.documentID)));
                },
                child: Text("Update Event"),
              ),
              TextButton(
                onPressed: () {
                  _deleteEvent(event.documentID, user);
                  Navigator.of(context).pop();
                },
                child: Text("Delete Event"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildAllGuestsCard(BuildContext context, DocumentSnapshot guest, String documentId, FirebaseUser user) {
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
                    guest['guestName'],
                    style: new TextStyle(fontSize: 22.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text("Contact Number: " + guest['guestContactNumber']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    Text("Email: " + guest['guestEmail']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.card_giftcard),
                    Text("Invitation Sent: " + guest['isInvited']),
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
                builder: (BuildContext context) => new InvitationCard(guest.documentID, documentId, user))),
      ),
    ),
  );
}
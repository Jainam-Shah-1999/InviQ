import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'About.dart';
import 'AllEvents.dart';
import 'CreateEvent.dart';
import 'UpdateEvent.dart';
import 'AddRegistrationCode.dart';
import 'Scanner.dart';

import 'package:flutter_application_1/Models/Event.dart';

class Dashboard extends StatefulWidget {
  final FirebaseUser user;
  Dashboard(this.user);
  @override
  _DashboardState createState() => _DashboardState(user);
}

class _DashboardState extends State<Dashboard> {
  final FirebaseUser user;
  _DashboardState(this.user);
  Future<void> _signOut() async {
    try {
      print('signing out' + user.displayName);
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print(e.toString());
    }
  }

  final List<Event> eventlist = [
    Event("New York", "BirthDay", DateTime.now(), TimeOfDay.now(),
        DateTime.now(), TimeOfDay.now(), "Ahmedabad", "5", "car", "No Notes"),
    Event("New York1", "BirthDay", DateTime.now(), TimeOfDay.now(),
        DateTime.now(), TimeOfDay.now(), "Ahmedabad", "5", "car", "No Notes"),
    Event("New York2", "BirthDay", DateTime.now(), TimeOfDay.now(),
        DateTime.now(), TimeOfDay.now(), "Ahmedabad", "5", "car", "No Notes"),
    Event("New York3", "BirthDay", DateTime.now(), TimeOfDay.now(),
        DateTime.now(), TimeOfDay.now(), "Ahmedabad", "5", "car", "No Notes"),
    Event("New York4", "BirthDay", DateTime.now(), TimeOfDay.now(),
        DateTime.now(), TimeOfDay.now(), "Ahmedabad", "5", "car", "No Notes"),
  ];
  @override
  Widget build(BuildContext context) {
    final event =
        new Event(null, null, null, null, null, null, null, null, null, null);
    return Scaffold(
      appBar: new AppBar(
        title: Text('InviQ'),
        backgroundColor: Color(0xff2E3791).withOpacity(0.5),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: Text(
              "Today's Events",
              style: TextStyle(fontSize: 25),
            ),
          ),
          new Expanded(
            child: new ListView.builder(
                itemCount: eventlist.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildEventCard(context, index)),
          ),
          new Expanded(
            flex: 0,
            child: new Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 25),
            ),
          ),
          new Expanded(
            child: new ListView.builder(
                itemCount: eventlist.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildEventCard(context, index)),
          )
        ],
      )),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(user.displayName),
              accountEmail: new Text(user.email),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(user.photoUrl),
              ),
            ),
            new ListTile(
              leading: Icon(Icons.home_outlined),
              title: new Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new Dashboard(user)));
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.app_registration),
              title: new Text('Register for an Event'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new AddRegistrationCodePage()));
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.add),
              title: new Text('Create Event'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new CreateEventPage(
                              event: event,
                              user: user,
                            )));
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.list_alt),
              title: new Text('All Events'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new AllEventsPage()));
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.info),
              title: new Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              leading: Icon(Icons.arrow_back),
              title: new Text('Log out'),
              onTap: () => _signOut(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context, int index) {
    final event = eventlist[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    event.eventName,
                    style: new TextStyle(fontSize: 22.0),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Event type: " + event.eventType),
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
                        "${DateFormat('dd/MM/yyyy').format(event.eventStartDate).toString()} - ${DateFormat('dd/MM/yyyy').format(event.eventEndDate).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.watch_rounded),
                    Text("${event.eventStartTime} - ${event.eventEndTime}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text("Location: " + event.eventLocation),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("Invited Guests: " + event.numberOfGuests),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

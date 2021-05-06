import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Pages
import 'About.dart';
import 'AllEvents.dart';
import 'CreateEvent.dart';
import 'AddRegistrationCode.dart';

//Models
import 'package:flutter_application_1/Models/Event.dart';

//widgets
import 'package:flutter_application_1/Widgets/EventListCard_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final event =
        new Event(null, null, null, null, null, null, null, null, null, null);
    return Scaffold(
      appBar: new AppBar(
        title: Text('InviQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            child: Column(
          children: <Widget>[
            new Expanded(
              flex: 0,
              child: Text(
                "Today's Events",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            new Expanded(
              child: StreamBuilder(
                  stream: getTodayEventsnapshot(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return new ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildTodaysEventCard(
                                context, snapshot.data.documents[index], user));
                  }),
            ),
            new Expanded(
              flex: 0,
              child: new Text(
                "Upcoming Events",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            new Expanded(
              child: StreamBuilder(
                  stream: getUpcomingEventsnapshot(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return new ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildUpcomingEventCard(
                                context, snapshot.data.documents[index], user));
                  }),
            )
          ],
        )),
      ),
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
                            new AddRegistrationCodePage(user)));
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
                            new AllEventsPage(user)));
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

  Stream<QuerySnapshot> getTodayEventsnapshot(BuildContext context) async* {
    yield* Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .where("eventStartDate", isLessThanOrEqualTo: DateTime.now().toString())
        .orderBy('eventStartDate', descending: true)
        .snapshots();
  }

// comment
  Stream<QuerySnapshot> getUpcomingEventsnapshot(BuildContext context) async* {
    yield* Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .orderBy('eventStartDate')
        .where("eventStartDate", isGreaterThan: DateTime.now().toString())
        .snapshots();
  }
}

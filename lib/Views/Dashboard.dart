import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    final event = new Event(null, null, null, null, null, null, null, null);
    return Scaffold(
      appBar: new AppBar(
        title: Text('InviQ'),
        backgroundColor: Color(0xff2E3791).withOpacity(0.5),
      ),
      body: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         Color(0xff2E3791).withOpacity(0.5),
          //         Color(0xff2DABE2).withOpacity(0.4)
          //       ]),
          // ),
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
            child: _buildListView(),
          ),
          new Expanded(
            flex: 0,
            child: new Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 25),
            ),
          ),
          new Expanded(
            child: _buildListView2(),
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

  ListView _buildListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('Event $index'),
          subtitle: Text('Event Notes'),
          leading: Icon(Icons.circle),
          trailing: IconButton(
            icon: Icon(Icons.qr_code_scanner_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new ScannerPage()));
            },
          ),
        );
      },
    );
  }

  ListView _buildListView2() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Icon(Icons.circle),
          title: Text('Event $index'),
          subtitle: Text('Event Notes'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new UpdateEventPage()));
            },
          ),
        );
      },
    );
  }
}

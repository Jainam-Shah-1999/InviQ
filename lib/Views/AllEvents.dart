import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//widgets
import 'package:flutter_application_1/Widgets/EventListCard_widget.dart';

class AllEventsPage extends StatefulWidget {
  final FirebaseUser user;
  AllEventsPage(this.user);
  @override
  _AllEventsPageState createState() => _AllEventsPageState(user);
}

class _AllEventsPageState extends State<AllEventsPage> {
  final FirebaseUser user;
  _AllEventsPageState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('All Events'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: new Text(
              "All Events",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          new Expanded(
            child: StreamBuilder(
                stream: getEventsnapshot(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildEventCardForUpdate(
                              context, snapshot.data.documents[index], user));
                }),
          ),
        ],
      )),
    );
  }

  Stream<QuerySnapshot> getEventsnapshot(BuildContext context) async* {
    yield* Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .orderBy('eventStartDate')
        .snapshots();
  }
}
